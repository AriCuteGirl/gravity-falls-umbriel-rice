# Gravity Falls Umbriel Rice

A portable EndeavourOS/Arch rice based on an Umbriel compositor, Noctalia shell, Kitty terminal, Thunar file manager, Catppuccin colours, pink borders, and a menu-driven terminal installer.

## Preview

[Watch the 47-second Gravity Falls rice preview](https://github.com/AriCuteGirl/gravity-falls-umbriel-rice/releases/download/v0.1.0/Gravity-Falls-Rice.mp4)

## Use

```bash
git clone https://github.com/AriCuteGirl/gravity-falls-umbriel-rice.git
cd gravity-falls-umbriel-rice
./install.sh
```

The installer has four stages: prerequisites (including optional multilib/Steam), Umbriel + Noctalia, rice files, and a keybind editor. Existing configs are backed up under `~/.local/state/umbriel-rice-backups` before changes.

It installs the JetBrains Mono Nerd, Pixelify Sans, and Noto font packages. The Gravity Falls Fastfetch image is placed in `~/Pictures/Gravity Falls Umbriel Rice/hug.png`.

## Safety and portability

Monitor layouts, wallpapers, avatars, usernames, autostarted personal apps, and private paths are intentionally excluded. Add your own monitor entries after installation with `umbriel outputs`.

## Default shortcuts

| Shortcut | Action |
|---|---|
| Super + Return | Kitty |
| Super + E | Thunar |
| Super + Period | Noctalia launcher |
| Super + Q | Close window |
| Super + O | Overview |
| Super + F | Toggle fullscreen for the focused window |
| Super + R | Cycle the focused window's primary size |

Run option 4 in the installer to change an existing keybind.
