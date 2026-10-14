#!/usr/bin/env bash

note(){ printf '\n\033[1;35m==>\033[0m %s\n' "$*"; }
pause(){ read -rp 'Press Enter to continue…' _; }
need_arch(){ [[ -f /etc/arch-release ]] || { printf 'This installer supports Arch/EndeavourOS only.\n' >&2; exit 1; }; }
backup(){ local target="$1" stamp; stamp="${XDG_STATE_HOME:-$HOME/.local/state}/umbriel-rice-backups/$(date +%Y%m%d-%H%M%S)"; mkdir -p "$stamp"; [[ -e "$target" ]] && cp -a "$target" "$stamp/"; printf '%s\n' "$stamp"; }

enable_multilib(){
  grep -q '^\[multilib\]' /etc/pacman.conf && return
  note 'Enabling Arch multilib (needed for Steam). A backup of pacman.conf is made.'
  local temp; temp="$(mktemp)"; sudo cp /etc/pacman.conf /etc/pacman.conf.umbriel-rice.bak
  awk 'BEGIN{on=0} /^#[[:space:]]*\[multilib\]/{sub(/^#[[:space:]]*/, "");on=1} on && /^#[[:space:]]*Include[[:space:]]*=/{sub(/^#[[:space:]]*/, "");on=0} {print}' /etc/pacman.conf > "$temp"
  sudo install -m 644 "$temp" /etc/pacman.conf; rm -f "$temp"; sudo pacman -Sy
}

install_prerequisites(){
  need_arch; enable_multilib
  note 'Installing core apps, Steam, and the archive integration.'
  sudo pacman -S --needed --noconfirm base-devel git kitty fish fastfetch thunar thunar-archive-plugin file-roller steam xdg-utils polkit-kde-agent qt6-wayland pipewire wireplumber grim slurp wl-clipboard
}

install_desktop(){
  need_arch
  sudo pacman -S --needed --noconfirm noctalia
  if command -v paru >/dev/null; then paru -S --needed --noconfirm umbriel-git
  elif command -v yay >/dev/null; then yay -S --needed --noconfirm umbriel-git
  else
    note 'Umbriel is an AUR package. Install paru or yay, then run this step again.'
    return 1
  fi
}

apply_rice(){
  local stamp; stamp="$(backup "$HOME/.config/umbriel")"; backup "$HOME/.config/noctalia" >/dev/null; backup "$HOME/.config/kitty" >/dev/null
  note "Backed up existing configuration under $stamp"
  install -Dm644 "$ROOT/assets/umbriel/config.toml" "$HOME/.config/umbriel/config.toml"
  install -Dm644 "$ROOT/assets/umbriel/rice.toml" "$HOME/.config/umbriel/rice.toml"
  install -Dm644 "$ROOT/assets/noctalia/rice.toml" "$HOME/.config/noctalia/rice.toml"
  install -Dm644 "$ROOT/assets/noctalia/config.toml" "$HOME/.config/noctalia/config.toml"
  install -Dm644 "$ROOT/assets/noctalia/palettes/Ari.json" "$HOME/.config/noctalia/palettes/Ari.json"
  install -Dm644 "$ROOT/assets/kitty/kitty.conf" "$HOME/.config/kitty/kitty.conf"
  install -Dm644 "$ROOT/assets/fish/config.fish" "$HOME/.config/fish/config.fish"
  note 'Rice installed. Log out, choose Umbriel at the display manager, then log back in.'
}

keybind_manager(){
  local config="$HOME/.config/umbriel/config.toml"
  [[ -f "$config" ]] || { note 'Apply the rice first.'; return; }
  note 'Current keybinds:'; awk '/^\[keybinds\]/{on=1;next} on && /^\[/{exit} on && /^"/{print}' "$config"
  read -rp 'Key to change (example: Mod+Return; blank cancels): ' key
  [[ -n "$key" ]] || return
  read -rp 'New action (example: spawn:kitty): ' action
  [[ -n "$action" ]] || return
  python - "$config" "$key" "$action" <<'PY'
import sys
p, key, action = sys.argv[1:]
s = open(p).read(); needle = f'"{key}" = '
lines = s.splitlines()
for i, line in enumerate(lines):
    if line.startswith(needle): lines[i] = f'"{key}" = {{ action = "{action}", repeat = false }}'; break
else: raise SystemExit(f'No existing bind named {key!r}.')
open(p, 'w').write('\n'.join(lines) + '\n')
PY
  umbriel config validate -c "$config" && umbriel config-replace "$config" || true
}
