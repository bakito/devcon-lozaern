# Requirements

This project uses [devbox](https://www.jetify.com/devbox) (which is built on top of [Nix](https://nixos.org/)) to manage dependencies, and [Tilt](https://tilt.dev) to manage the local Kubernetes cluster for live demos.

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

### Tab Completion

Inside `devbox shell` the alias `dbrun` (short for `devbox run`, defined in the `init_hook` of `devbox.json`) is available, and tab completion for devbox task names (`devbox run <TAB>`, `dbrun <TAB>` and the `dbr` alias) is enabled automatically.

To use it outside of `devbox shell`, load it manually in bash or zsh:

```bash
source setup/completion.bash
```

Or enable it permanently by adding this line to your `~/.bashrc` or `~/.zshrc`:

```bash
source /path/to/devcon-lozaern/setup/completion.bash
```

### DevCon Presentation

- **Run presentation**: `devbox run present`
- **Export to PDF**: `devbox run pdf`
- **Export to HTML**: `devbox run html`

### Kubexporter Presentation

The live demos run against the kind cluster `kubexporter-demo` (namespace `kubexporter-test`). Cluster setup is managed by [Tilt](https://tilt.dev) via the `Tiltfile`.

- **Start cluster and resources**: `devbox run kind-setup` (runs `tilt up`)
- **Stop cluster and resources**: `devbox run kind-destroy` (runs `tilt down`)
- **Run presentation**: `devbox run k-present` (sets up cluster, runs slides, then tears down)
- **Export to PDF**: `devbox run k-pdf`
- **Export to HTML**: `devbox run k-html`

#### Tilt Dashboard

For interactive development, run `tilt up` directly to open the Tilt dashboard (http://localhost:10350). It provides:
- Real-time status of all Kubernetes resources
- Log streaming from deployed services
- Automatic rebuilds when manifests change

## excalidraw

https://excalidraw.com/#json=ITgkNv-ASxc4PULGVwdSc,x1iq3B_XlabKcnKE5INLXw