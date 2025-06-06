# My NixOS Dotfiles
This is my NixOS configuration! ^.^ \
Most of these 'docs' are for future me, for if I forget how this configuration was structured.

### Useful stuff
- [Nix Package Versions](https://lazamar.co.uk/nix-versions)
- [Release Notes](https://nixos.org/manual/nixos/stable/release-notes)
- [Release Status](https://endoflife.date/nixos)
- [Find Song Name](https://musikerkennung.com/en/) (Not related to NixOS, but it's a useful tool i use!)

## TODO
- [x] Split `global_modules` into profiles, in case i add more devices that need vastly different stuff in the future?
  - [ ] Add an `extras/` folder for niche “default” configurations, eg. Nvidia GPUs and Steam.
  - Profiles could be split as `light`, `full`, `dev` and `games`? With a “Central” `core` shared by all.
- [x] Remove all references to `home-librewolf` once [this PR](https://github.com/nix-community/home-manager/pull/5684) is backported

<br>

- Wait for GTK4 port of [GNOME Disks](https://gitlab.gnome.org/GNOME/gnome-disk-utility/-/merge_requests/91).
- Wait for GTK4 port of [Dconf Editor](https://gitlab.gnome.org/GNOME/dconf-editor/-/merge_requests/44).
- Wait for [Noteworthy](https://github.com/SeaDve/Noteworthy) to be available on nixpkgs.

## Bootstrapping the config
1. Follow the [NixOS manual](https://nixos.org/manual/nixos/stable/#sec-installation-manual) up until #Installing->5.
   - See [Creatign a bootable USB](https://nixos.org/manual/nixos/stable/#sec-booting-from-usb-linux) if needed.
3. Install git (`nix-env -f '<nixpkgs>' -iA git`) and clone this repo.
4. Set up the host and then run `git add .`. See [Adding A Host](#adding-a-host).
5. Install NixOS with `nixos-install --root /mnt --flake ./dotfiles#<host>`.
6. Set a password for the user with `nixos-enter --root /mnt -c 'passwd gemini'`.
7. Move the repo to `/mnt/home/gemini` and reboot.

## Adding a host
Make a new file in `dotfiles/hosts/<hostname>/<hostname>.nix`, and then add the host to `dotfiles/flakes.nix`. \
This new file can contain custom configurations for the host.

Then copy the file at `/etc/nixos/hardware-configuration.nix` to `dotfiles/hosts/<hostname>/<hostname>-hardware.nix` otherwise the host wont boot! \
Follow how it's implemented on other hosts to do it correctly!

> [!CAUTION]
> The host **must** define in their flake outputs section these variables in `specialArgs`:
> ```
> host-system = {
>   hostname = "<hostname>";
>   initial-version = "<first_installed_nixos_version";
> };
> 
> gpg-keys = {
>   master-id = "<key_id>";
>   auth-keygrip = "<auth_capable_subkey_keygrip>";
> };
> ```
>
> More detailed instructions for the GPG keys section [here](https://github.com/StellarSt0rm/dotfiles_secrets).

## Extra
- [Disk Encryption](https://qfpl.io/posts/installing-nixos/#encryption-and-lvm)
- [Secure Boot](https://github.com/nix-community/lanzaboote/blob/master/docs/QUICK_START.md)
