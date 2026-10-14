#!/usr/bin/env bash
set -Eeuo pipefail

ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
source "$ROOT/lib/common.sh"

main_menu() {
  while true; do
    clear
    printf '\n  Umbriel Catppuccin Rice\n  %s\n\n' '────────────────────────'
    select option in '1. Install prerequisites' '2. Install Umbriel + Noctalia' '3. Apply the rice' '4. Keybind manager' '5. Full install' 'Quit'; do
      case "$REPLY" in
        1) install_prerequisites ;;
        2) install_desktop ;;
        3) apply_rice ;;
        4) keybind_manager ;;
        5) install_prerequisites; install_desktop; apply_rice ;;
        6) exit 0 ;;
        *) note 'Choose a numbered option.' ;;
      esac
      pause; break
    done
  done
}

main_menu
