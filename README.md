# Umbriel Catppuccin Rice

A portable EndeavourOS/Arch rice based on an Umbriel compositor, Noctalia shell, Kitty terminal, Thunar file manager, Catppuccin colours, pink borders, and a menu-driven terminal installer.

## Use

```bash
git clone https://github.com/YOUR-USER/umbriel-catppuccin-rice.git
cd umbriel-catppuccin-rice
./install.sh
```

The installer has four stages: prerequisites (including optional multilib/Steam), Umbriel + Noctalia, rice files, and a keybind editor. Existing configs are backed up under `~/.local/state/umbriel-rice-backups` before changes.

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

Run option 4 in the installer to change an existing keybind.
