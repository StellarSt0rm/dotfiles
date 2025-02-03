# My NixOS Dotfiles
This is my NixOS configuration! ^.^ \
Most of these 'docs' are for future me, for if I forget how this configuration was structured.

### Useful stuff
- [Nix Package Versions](https://lazamar.co.uk/nix-versions)

# TODO
- [X] Configure librewolf with Home Manager. [Ref1](https://github.com/Misterio77/nix-config/blob/main/home/gabriel/features/desktop/common/firefox.nix), [Ref2](https://gitlab.com/usmcamp0811/dotfiles/-/blob/fb584a888680ff909319efdcbf33d863d0c00eaa/modules/home/apps/firefox/default.nix), **[Ref3](https://github.com/nix-community/home-manager/issues/6154)**. [Doc1](https://nix-community.github.io/home-manager/options.xhtml#opt-programs.librewolf.settings), [Doc2](https://librewolf.net/docs/settings/). **[NUR](https://nur.nix-community.org/documentation/#using-the-flake-in-nixos)**. | [Help1](https://nixos.wiki/wiki/Librewolf#System-wide), [Help1.2](https://mynixos.com/home-manager/option/programs.firefox.package). [Extra1](https://github.com/nix-community/home-manager/pull/5128), [Extra2](https://github.com/nix-community/home-manager/pull/5684).
- [ ] Split `global_modules` into profiles, in case i add more devices that need vastly different stuff in the future?
- [ ] Remove all references to `home-librewolf` once [this PR](https://github.com/nix-community/home-manager/pull/5684) is backported
- [ ] Try to get [this patch](https://discourse.nixos.org/t/gdm-background-image-and-theme/12632/4) working.

<br>

- Wait for GTK4 port of [GNOME Disks](https://gitlab.gnome.org/GNOME/gnome-disk-utility/-/merge_requests/91).
- Wait for GTK4 port of [Dconf Editor](https://gitlab.gnome.org/GNOME/dconf-editor/-/merge_requests/44).
- Wait for [Noteworthy](https://github.com/SeaDve/Noteworthy) to be available on nixpkgs.

# Bootstrapping the config
1. Install with no desktop environment, and make a user named `gemini`.
2. Configure and connect to a network. See [Connecting to a network](#connecting-to-a-network).
4. `git clone` this repo somewhere. (Preferably $HOME for easy editing)
5. Add the new host to the configuration. See [Adding a host](#adding-a-host).
   - Make sure to run `git add .` once done, otherwise the new files wont be seen by nix.
6. Run `nix-rebuild boot --flake ./dotfiles#<hostname>` and reboot.

# Adding a host
Make a new file in `dotfiles/hosts/<hostname>/<hostname>.nix`, and then add the host to `dotfiles/flakes.nix`. \
This new file can contain custom configurations for the host.

Follow how it's implemented on other hosts to do it correctly!

> [!CAUTION]
> The file `hosts/<hostname>/<hostname>.nix` **must** define: \
> `networking.hostName`, `system.stateVersion` and `home-manager.users.gemini.home.stateVersion`!
>
> It also has to import `./<hostname>-hardware.nix` (Copy from `/etc/nixos/hardware-configuration.nix`).

# Connecting to a network
   1. Make a new wpa_supplicant config (`nano /tmp/wpa.conf`) and write to it:
      ```
      network={
        ssid="<SSID>"
        psk="<PASSWORD>"
      }
      ```
   2. Start wpa_supplicant with the config:
      ```
      ifconfig # Get device name
      sudo systemctl stop NetworkManager # If the system has NetworkManager, stop it!

      sudo wpa_supplicant -i <DEVICE> -c /tmp/wpa.conf
      ```
   3. If the network doesnt have DHCP:
      ```
      ifconfig # Get the network IP for the device

      sudo ip addr add <IP>/24 dev <DEVICE>
      sudo ip route add default via <IP>
      ```
   4. Check the connection: `ping itsfoss.com`
