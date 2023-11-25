# see https://discourse.nixos.org/t/nix-shell-how-to-run-corepack-enable-to-install-modern-yarn/18791/4

{
  stdenvNoCC,
  nodejs
}:
stdenvNoCC.mkDerivation rec {
  name = "corepack";
  buildInputs = [nodejs];
  phases = ["installPhase"];

  installPhase = ''
    mkdir -p "$out/bin"
    corepack enable --install-directory="$out/bin"
  '';
}
