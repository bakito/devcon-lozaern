# Requirements

This project uses [Nix](https://nixos.org/) and [devbox](https://jetify.com/devbox/) to manage dependencies. Make sure both are installed before proceeding.

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
