# My NixOS Dotfiles
This is my NixOS config!

Most of these 'docs' are for future me, for if I forget how this configuration was structured.

# Bootstrapping the config
1. Setup a user named `gemini`.
3. `git clone` this repo somewhere. (Preferably $HOME for easy editing)
4. Overwrtie the contents of `/etc/nixos/configuration.nix` with `dotfiles/bootstrap.nix`.
   - **Make sure** the host is set! See [#Adding a host](#adding-a-host).
5. Copy `/etc/nixos/hardware-configuration.nix` to `dotfiles/hosts/<host>/hardware.nix`.
6. Run `nix-rebuild switch` to apply the changes.
7. Run `nix-rebuild boot --flake ./dotfiles#<hostame>` and reboot.
8. (Optional) Finish setting up `gh auth` and upload any changes you made while bootstrapping.

# Adding a host
Make a new file in `dotfiles/hosts/<hostname>.nix`, and then add the host to `dotfiles/flakes.nix`. \
This new file can contain custom configurations for the host.

Follow how it's implemented on other hosts to do it correctly.

> [!CAUTION]
> The file in `hosts/` **must** define `networking.hostName` and `system.stateVersion`!
