{
  description = "Enable NodeJS corepack";

  inputs.nixpkgs.url = "nixpkgs/release-22.11";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    {
      overlays = {
        corepack = final: prev: {
          corepack = self.packages.${prev.system}.corepack;
        };
        yarn = final: prev: {
          yarn = self.packages.${prev.system}.yarn;
        };
        pnpm = final: prev: {
          pnpm = self.packages.${prev.system}.pnpm;
        };
        default = self.overlays.corepack;
      };
    }
    // flake-utils.lib.eachDefaultSystem (system:
      let
        src = import ./src.nix;
        pkgs = import nixpkgs { inherit system; };
        corepack = import ./corepack.nix { inherit pkgs; };
        fixedCorepack = corepack.fixedCorepack src.archive;
      in rec {
        packages.corepack = corepack.projectSpecCorepack;
        packages.yarn = fixedCorepack.overrideAttrs (finalAttrs: prevAttrs: {
          name = "yarn";
          version = src.yarn.version;
          meta.mainProgram = "yarn";
        });
        packages.pnpm = fixedCorepack.overrideAttrs (finalAttrs: prevAttrs: {
          name = "pnpm";
          version = src.pnpm.version;
          meta.mainProgram = "pnpm";
        });
        packages.pnpx = fixedCorepack.overrideAttrs (finalAttrs: prevAttrs: {
          name = "pnpx";
          version = src.pnpm.version;
          meta.mainProgram = "pnpx";
        });

        packages.default = packages.corepack;
      }
    );
}
