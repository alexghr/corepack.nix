# corepack.nix

[Corepack] is a tool to manage Node.js package managers. This repo provide a list of Nix expressions to use it.

## Enable all package managers

Install the `corepack` package (also the default package) will enable all of the Node.js package managers that Corepack knows about. These will be their respective latest version when the package was last built.

```bash
$ nix shell github:alexghr/corepack.nix
$ command -v yarn
/nix/store/2h6r0rj0rqqcpsw1zad5hm7f4fz5y075-corepack/bin/yarn
$ command -v pnpm
/nix/store/2h6r0rj0rqqcpsw1zad5hm7f4fz5y075-corepack/bin/pnpm
$ command -v pnpx
/nix/store/2h6r0rj0rqqcpsw1zad5hm7f4fz5y075-corepack/bin/pnpx
```

## Enable a specific package manager

This repo exports each Node.js package manager as a derivation:

```bash
$ nix run github:alexghr/corepack.nix#pnpm -- --version
7.22.0
$ nix run github:alexghr/corepack.nix#yarn -- --version
1.22.19
```

## Run one-off `pnpx` scripts

This repo also exports the pnpx tool. You can use it to run one-off download-and-execute scripts through pnpm:

```bash
$ nix run github:alexghr/corepack.nix#pnpx -- create-react-app ./todo-mvc
Creating a new React app in
```

## Version management

Corepack does version management via an entry in `package.json`:

```json
  "name": "test",
  "version": "1.0.0",
  "packageManager": "pnpm@7.30.3"
```

Corepack will automatically download pnpm v7.30.3 the first time any `pnpm` command is used.

[Corepack]: https://nodejs.org/api/corepack.html
