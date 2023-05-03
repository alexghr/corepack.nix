#/usr/bin/env bash

set -eu -o pipefail

PNPM_VERSION="8.4.0"
YARN_VERSION="1.22.19"

corepack prepare pnpm@$PNPM_VERSION yarn@$YARN_VERSION --output=corepack.tgz > /dev/null 2>&1

cat > "src.nix" <<EOF
# DO NOT MODIFY
# This is a generated file. See $0 for details
{
  archive = ./corepack.tgz;
  pnpm.version = "v$PNPM_VERSION";
  yarn.version = "v$YARN_VERSION";
}
EOF
