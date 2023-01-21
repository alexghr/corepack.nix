# see https://discourse.nixos.org/t/nix-shell-how-to-run-corepack-enable-to-install-modern-yarn/18791/4

{ pkgs }:
pkgs.stdenv.mkDerivation rec {
  name = "corepack";
  nodejsPkg = pkgs.nodejs-18_x;
  buildInputs = [nodejsPkg];
  phases = ["installPhase"];
  installPhase = ''
    mkdir -p "$out/bin"
    corepack enable --install-directory="$out/bin"
  '';
}
