#!/usr/bin/env bash
# set -euo pipefail

N="${1:-99999}"

mapfile -t pkgs < <(pacman -Qqe | sort | head -n "$N")

for pkg in "${pkgs[@]}"; do
  desc="$(pacman -Qi "$pkg" | awk -F': ' '/^Description/{print $2}')"
  size="$(pacman -Qi "$pkg" | awk -F': ' '/^Installed Size/{print $2}')"

  echo "\F0\9F\93\A6 $pkg"
  echo "   size: $size"
  echo "   about: $desc"

  cmds="$(pacman -Ql "$pkg" \
    | awk '{print $2}' \
    | grep -E '^(/usr)?/(sbin|bin)/' \
    | xargs -r -n1 basename \
    | sort -u \
    | tr '\n' ' ')"

  if [[ -n "${cmds// }" ]]; then
    echo "   run: $cmds"
  else
    echo "   run: (no commands \E2\80\94 library/driver/theme/etc)"
  fi

  echo
done