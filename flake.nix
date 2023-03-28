{
  description = "Enable NodeJS corepack";

  inputs.nixpkgs.url = "nixpkgs/release-22.11";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in rec {
        packages.corepack = import ./corepack.nix { inherit pkgs; };
        packages.yarn = packages.corepack.overrideAttrs (finalAttrs: prevAttrs: {
          name = "yarn";
          meta.mainProgram = "yarn";
        });
        packages.pnpm = packages.corepack.overrideAttrs (finalAttrs: prevAttrs: {
          name = "pnpm";
          meta.mainProgram = "pnpm";
        });
        packages.pnpx = packages.corepack.overrideAttrs (finalAttrs: prevAttrs: {
          name = "pnpx";
          meta.mainProgram = "pnpx";
        });

        packages.default = packages.corepack;
      }
    );
}
