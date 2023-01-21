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
        packages.default = packages.corepack;
      }
    );
}
