#!/usr/bin/env bash

set -e

BATS_ROOT="${0%/*}"
PREFIX="$1"
LIBDIR="${2:-lib}"

if [[ -z "$PREFIX" ]]; then
  printf '%s\n' \
    "usage: $0 <prefix>" \
    "  e.g. $0 /usr/local" >&2
  exit 1
fi

ln -sf -t "$PREFIX/bin" "$(realpath "$BATS_ROOT/bin/bats")"
rm -r "$PREFIX/libexec/bats-core"
ln -sf -T "$(realpath "$BATS_ROOT/libexec/bats-core")" "$PREFIX/libexec/bats-core"
rm -r "$PREFIX/${LIBDIR}/bats-core"
ln -sf -T "$(realpath "$BATS_ROOT/lib/bats-core")" "$PREFIX/${LIBDIR}/bats-core"
# NOTE: You can `install.sh` again to remove the symlinks and return to the normal state

echo "Symlinked Bats to $PREFIX/bin/bats"
