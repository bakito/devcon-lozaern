# Requirements

This project uses [devbox](https://www.jetify.com/devbox) (which is built on top of [Nix](https://nixos.org/)) to manage dependencies.

## Installing devbox

The easiest way to install devbox is using the official install script (run it as a **non-root user**). If Nix is not present, devbox will automatically install it the first time you run a devbox command:

```bash
curl -fsSL https://get.jetify.com/devbox | bash
```

After installation, reload your shell and verify devbox is working:

```bash
devbox version
```

### Alternative: Manual Installation

If you prefer to install Nix and devbox manually:

1. **Install Nix** using the [Determinate Nix Installer](https://github.com/DeterminateSystems/nix-installer):

    ```bash
    curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
    ```

2. **Install devbox** via Nix:

    ```bash
    nix profile add nixpkgs#devbox
    ```

    Or, for the latest version via Nix Flake:

    ```bash
    nix profile add github:jetify-com/devbox/latest
    ```

    > **Note:** `nix profile add` requires Nix 2.29 or newer. On older Nix versions use `nix profile install` instead.

For more details, see the [devbox documentation](https://www.jetify.com/docs/devbox/installing-devbox).

## Setup

Open a devbox shell to install all required packages:

```bash
devbox shell
```

## Devbox Tasks

### DevCon Presentation

- **Run presentation**: `devbox run devcon-present`
- **Export to PDF**: `devbox run devcon-pdf`
- **Export to HTML**: `devbox run devcon-html`

### Kubexporter Presentation

- **Run presentation**: `devbox run kubexporter-present`
- **Export to PDF**: `devbox run kubexporter-pdf`
- **Export to HTML**: `devbox run kubexporter-html`
