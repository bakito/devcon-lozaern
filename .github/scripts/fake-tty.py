#!/usr/bin/env python3
"""Run a command inside a pseudo terminal that answers basic terminal queries.

presenterm queries the terminal (device attributes, status report, cursor
position) on startup and blocks until it gets an answer. CI runners have no
real terminal, so this wrapper emulates the minimal responses needed.

Usage: fake-tty.py [--rows N] [--cols N] -- command [args...]
"""
import argparse
import fcntl
import os
import pty
import select
import struct
import sys
import termios

RESPONSES = {
    b"\x1b[c": b"\x1b[?62;22c",  # primary device attributes
    b"\x1b[5n": b"\x1b[0n",  # device status report: OK
    b"\x1b[6n": b"\x1b[1;1R",  # cursor position report
}


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--rows", type=int, default=60)
    parser.add_argument("--cols", type=int, default=160)
    parser.add_argument("command", nargs=argparse.REMAINDER)
    args = parser.parse_args()
    command = args.command[1:] if args.command[:1] == ["--"] else args.command
    if not command:
        parser.error("missing command")

    pid, fd = pty.fork()
    if pid == 0:
        os.execvp(command[0], command)

    fcntl.ioctl(fd, termios.TIOCSWINSZ, struct.pack("HHHH", args.rows, args.cols, 0, 0))

    buffer = b""
    while True:
        try:
            ready, _, _ = select.select([fd], [], [], 1.0)
        except InterruptedError:
            continue
        if not ready:
            continue
        try:
            data = os.read(fd, 65536)
        except OSError:
            break
        if not data:
            break
        sys.stdout.buffer.write(data)
        sys.stdout.buffer.flush()

        buffer = (buffer + data)[-64:]
        for query, response in RESPONSES.items():
            while query in buffer:
                os.write(fd, response)
                buffer = buffer.replace(query, b"", 1)

    _, status = os.waitpid(pid, 0)
    return os.waitstatus_to_exitcode(status)


if __name__ == "__main__":
    sys.exit(main())
