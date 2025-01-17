# My NixOS Dotfiles
This is my NixOS config!

Most of these 'docs' are for future me, for if I forget how this configuration was structured.

# Bootstrapping the config
1. Setup a user with the name `gemini`.
3. `git clone` this repo somewhere. (Preferably $HOME for easy editing)
4. Overwrtie the contents of `/etc/nixos/configuration.nix` with `dotfiles/bootstrap.nix`.
   - **Make sure** the host is set! See [Adding a host](#adding-a-host).
5. Run `nix-rebuild switch` to apply the changes.
6. Run `nix-rebuild boot --flake ./dotfiles#<hostame>` and reboot.
7. (Optional) Finish setting up `gh auth` and upload any changes you made while bootstrapping.

# Adding a host
Make a new file in `dotfiles/hosts/<hostname>.nix`, and then add the host to `dotfiles/flakes.nix`, this new file can contain custom configurations.

Follow how it's implemented on other hosts to do it correctly.

> [!CAUTION]
> The file in `hosts/` **must** define `networking.hostName` and `system.stateVersion`!
