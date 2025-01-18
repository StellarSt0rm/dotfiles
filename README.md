# My NixOS Dotfiles
This is my NixOS configuration! ^.^

Most of these 'docs' are for future me, for if I forget how this configuration was structured.

# TODO
- Wait for GTK4 port of [GNOME Disks](https://gitlab.gnome.org/GNOME/gnome-disk-utility/-/merge_requests/91)
- Wait for GTK4 port of [Dconf Editor](https://gitlab.gnome.org/GNOME/dconf-editor/-/merge_requests/44)

# Bootstrapping the config
1. Install with no desktop environment, and make a user named `gemini`.
2. `git clone` this repo somewhere. (Preferably $HOME for easy editing)
3. Add the new host to the configuration. See [Adding a host](#adding-a-host).
   - Make sure to run `git add .` once done, otherwise the new files wont be seen by nix.
4. Run `nix-rebuild boot --flake ./dotfiles#<hostname>` and reboot.

A final step could be to `gh auth login` and upload any changes made while bootstrapping.

# Adding a host
Make a new file in `dotfiles/hosts/<hostname>/<hostname>.nix`, and then add the host to `dotfiles/flakes.nix`. \
This new file can contain custom configurations for the host.

Follow how it's implemented on other hosts to do it correctly!

> [!CAUTION]
> The file `hosts/<hostname>/<hostname>.nix` **must** define `networking.hostName`, `system.stateVersion` and `home-manager.users.gemini.home.stateVersion`! \
> It also has to import `./<hostname>-hardware.nix` (Copy from `/etc/nixos/hardware-configuration.nix`).
