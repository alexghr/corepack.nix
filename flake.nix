{
  description = "Enable NodeJS corepack";

  inputs.nixpkgs.url = "nixpkgs/nixpkgs-unstable";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    {
      overlays = {
        yarn = final: prev: {
          yarn = self.packages.${prev.system}.yarn;
        };
        pnpm = final: prev: {
          pnpm = self.packages.${prev.system}.pnpm;
        };
        corepack = final: prev: {
          corepack = self.packages.${prev.system}.corepack;
        };
        default = self.overlays.corepack;
      };
    }
    // flake-utils.lib.eachDefaultSystem (system:
      let
        src = import ./src.nix;
        pkgs = nixpkgs.legacyPackages.${system};
        corepack = pkgs.callPackage ./corepack.nix {};
        shim = pkgs.callPackage ./shim.nix {};
      in rec {
        packages.yarn = shim.overrideAttrs (finalAttrs: prevAttrs: {
          name = "yarn";
          version = src.yarn.version;
          meta.mainProgram = "yarn";
        });

        packages.pnpm = shim.overrideAttrs (finalAttrs: prevAttrs: {
          name = "pnpm";
          version = src.pnpm.version;
          meta.mainProgram = "pnpm";
        });

        packages.pnpx = shim.overrideAttrs (finalAttrs: prevAttrs: {
          name = "pnpx";
          version = src.pnpm.version;
          meta.mainProgram = "pnpx";
        });

        packages.corepack = corepack;
        packages.default = packages.corepack;
      }
    );
}
