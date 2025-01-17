# My NixOS Dotfiles
This is my NixOS config!

Most of these 'docs' are for future me, for if I forget how this configuration was structured.

# Bootstrapping the config
1. Setup a user named `gemini`.
2. `git clone` this repo somewhere. (Preferably $HOME for easy editing)
3. Add the new host to the configuration. See [Adding a host](#adding-a-host).
   - Make sure to run `git add` once you're done.
4. Enable `flakes`, add `nix.settings.experimental-features = [ "flakes" ];`
5. Copy `/etc/nixos/hardware-configuration.nix` to `dotfiles/hosts/<hostname>/<hostname>-hardware.nix`.
6. Run `nix-rebuild switch` to apply the changes.
7. Run `nix-rebuild boot --flake ./dotfiles#<hostame>` and reboot.
8. (Optional) Finish setting up `gh auth` and upload any changes you made while bootstrapping.

# Adding a host
Make a new file in `dotfiles/hosts/<hostname>/<hostname>.nix`, and then add the host to `dotfiles/flakes.nix`. \
This new file can contain custom configurations for the host.

Follow how it's implemented on other hosts to do it correctly.

> [!CAUTION]
> The file `hosts/<hostname>/<hostname>.nix` **must** define `networking.hostName`, `system.stateVersion` and `home-manager.users.gemini.home.stateVersion`!
> It's also recommended you import a `hardware-configuration.nix`.
