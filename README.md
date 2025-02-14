# My NixOS Dotfiles
This is my NixOS configuration! ^.^ \
Most of these 'docs' are for future me, for if I forget how this configuration was structured.

### Useful stuff
- [Nix Package Versions](https://lazamar.co.uk/nix-versions)
- [Release Notes](https://nixos.org/manual/nixos/stable/release-notes)
- [Release Status](https://endoflife.date/nixos)

# TODO
- [X] Configure librewolf with Home Manager. [Ref1](https://github.com/Misterio77/nix-config/blob/main/home/gabriel/features/desktop/common/firefox.nix), [Ref2](https://gitlab.com/usmcamp0811/dotfiles/-/blob/fb584a888680ff909319efdcbf33d863d0c00eaa/modules/home/apps/firefox/default.nix), **[Ref3](https://github.com/nix-community/home-manager/issues/6154)**. [Doc1](https://nix-community.github.io/home-manager/options.xhtml#opt-programs.librewolf.settings), [Doc2](https://librewolf.net/docs/settings/). **[NUR](https://nur.nix-community.org/documentation/#using-the-flake-in-nixos)**. | [Help1](https://nixos.wiki/wiki/Librewolf#System-wide), [Help1.2](https://mynixos.com/home-manager/option/programs.firefox.package). [Extra1](https://github.com/nix-community/home-manager/pull/5128), [Extra2](https://github.com/nix-community/home-manager/pull/5684).
- [ ] Split `global_modules` into profiles, in case i add more devices that need vastly different stuff in the future?
- [ ] Remove all references to `home-librewolf` once [this PR](https://github.com/nix-community/home-manager/pull/5684) is backported

<br>

- Wait for GTK4 port of [GNOME Disks](https://gitlab.gnome.org/GNOME/gnome-disk-utility/-/merge_requests/91).
- Wait for GTK4 port of [Dconf Editor](https://gitlab.gnome.org/GNOME/dconf-editor/-/merge_requests/44).
- Wait for [Noteworthy](https://github.com/SeaDve/Noteworthy) to be available on nixpkgs.

# Bootstrapping the config
1. Follow the [NixOS manual](https://nixos.org/manual/nixos/stable/#sec-installation-manual) up until #Installing->5.
2. Install git (`nix-env -f '<nixpkgs>' -iA git`) and clone this repo.
3. Set up the host and then run `git add .`. See [Adding A Host](#adding-a-host).
4. Install NixOS with `nixos-install --root /mnt --flake ./dotfiles#<host>`.
5. Set a password for the user with `nixos-enter --root /mnt -c 'passwd gemini'`.
6. Reboot.

# Adding a host
Make a new file in `dotfiles/hosts/<hostname>/<hostname>.nix`, and then add the host to `dotfiles/flakes.nix`. \
This new file can contain custom configurations for the host.

Follow how it's implemented on other hosts to do it correctly!

> [!CAUTION]
> The file `hosts/<hostname>/<hostname>.nix` **must** define: \
> `networking.hostName`, `system.stateVersion` and `home-manager.users.gemini.home.stateVersion`!
>
> It also has to import `./<hostname>-hardware.nix` (Copy from `/etc/nixos/hardware-configuration.nix`).

> [!NOTE]
> It's recommended to setup SSH and GPG keys, read the [instructions](https://github.com/StellarSt0rm/dotfiles_secrets).
