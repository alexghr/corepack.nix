
{
  stdenvNoCC,
  nodejs,
  makeWrapper
}:
stdenvNoCC.mkDerivation rec {
  name = "shim";
  src = ./corepack.tgz;

  nativeBuildInputs = [makeWrapper];
  buildInputs = [nodejs];

  phases = ["unpackPhase" "installPhase"];

  COREPACK_HOME="$out/corepack";
  COREPACK_ENABLE_NETWORK = "0";
  COREPACK_ENABLE_PROJECT_SPEC = "0";
  COREPACK_ENABLE_STRICT = "0";

  unpackPhase = ''
    mkdir -p "${COREPACK_HOME}"
    export COREPACK_HOME=${COREPACK_HOME}
    corepack hydrate $src --activate
  '';

  installPhase = ''
    mkdir -p "$out/bin"

    # creates shims
    corepack enable --install-directory="$out/bin"

    # wrap each shim to forward env vars (specifically COREPACK_HOME)
    # this way corepack will "see" the version we just installed
    # and won't default to its last known good version
    for file in $out/bin/*
    do
      wrapProgram $file \
        --set COREPACK_HOME "${COREPACK_HOME}" \
        --set COREPACK_ENABLE_NETWORK "${COREPACK_ENABLE_NETWORK}" \
        --set COREPACK_ENABLE_PROJECT_SPEC "${COREPACK_ENABLE_PROJECT_SPEC}" \
        --set COREPACK_ENABLE_STRICT "${COREPACK_ENABLE_STRICT}"
    done
  '';
}
