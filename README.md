# Requirements

This project uses [Nix](https://nixos.org/) and [devbox](https://jetify.com/devbox/) to manage dependencies. Make sure both are installed before proceeding.

### Installing Nix

Install Nix using the official installer. On Linux and macOS, run:

```bash
sh <(curl -L https://nixos.org/nix/install) --daemon
```

After installation, reload your shell or run `nix --version` to verify it works.

### Installing devbox

Once Nix is installed, install devbox:

```bash
nix profile install nixpkgs#devbox
```

Verify the installation:

```bash
devbox --version
```

For more details, see the [devbox documentation](https://jetify.com/devbox/).

## Setup

Open a devbox shell to install all required packages:

```bash
devbox shell
```

## Devbox Tasks

### DevCon Presentation

- **Run presentation**: `devbox run devcon-present`
- **Export to PDF**: `devbox run devcon-pdf`

### Kubexporter Presentation

- **Run presentation**: `devbox run kubexporter-present`
- **Export to PDF**: `devbox run kubexporter-pdf`
