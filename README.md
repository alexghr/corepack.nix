# corepack.nix

[Corepack] is a tool to manage Node.js package managers. This repo provide a list of Nix expressions to use it.

## Enable all package managers

Install the `corepack` package will enable all of the Node.js package managers that Corepack knows about. These will be their respective latest version when the package was last built.

```bash
$ nix shell github:alexghr/corepack.nix
$ command -v yarn
/nix/store/2h6r0rj0rqqcpsw1zad5hm7f4fz5y075-corepack/bin/yarn
$ command -v pnpm
/nix/store/2h6r0rj0rqqcpsw1zad5hm7f4fz5y075-corepack/bin/pnpm
$ command -v pnpx
/nix/store/2h6r0rj0rqqcpsw1zad5hm7f4fz5y075-corepack/bin/pnpx
```

## Running one-off package manager commands

This repo exports each Node.js package manager as a derivation:

```bash
$ nix run github:alexghr/corepack.nix#pnpm -- --version
8.0.0
$ nix run github:alexghr/corepack.nix#yarn -- --version
1.22.19
```

Use these for one-off commands that you might need to run. These are fixed
versions of package managers and won't respect the `packageManager` field in
`package.json`.

Update versions in [gen-src.bash](./gen-src.bash).

### pnpx

This repo also exports the pnpx tool. You can use it to run one-off download-and-execute scripts through pnpm:

```bash
$ nix run github:alexghr/corepack.nix#pnpx -- create-react-app ./todo-mvc
Creating a new React app in ...
```

## `package.json` version management

The default package observes version management through the `packageManager`
field in `package.json`:

```bash
$ nix shell github:alexghr/corepack.nix
$ cat package.json
{
  "name": "test",
  "version": "1.0.0",
  "packageManager": "pnpm@7.30.3"
}
$ pnpm --version
7.30.3
```

These versioned package managers are stored in [`$COREPACK_HOME`](https://github.com/nodejs/corepack#environment-variables).
It defaults to `~/.cache/node/corepack`.

[Corepack]: https://nodejs.org/api/corepack.html
