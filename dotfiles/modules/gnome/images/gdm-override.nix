# https://discourse.nixos.org/t/gdm-background-image-and-theme/12632/4

{ pkgs, ... }: {
  nixpkgs = {
    overlays = [
      (self: super: {
        gnome = super.gnome.overrideScope' (selfg: superg: {
          gnome-shell = superg.gnome-shell.overrideAttrs (old: {
            patches = (old.patches or [ ]) ++ [
              (pkgs.substituteAll {
                src = ./gnome-shell_3.38.3.patch;
              })
            ];
          });
        });
      })
    ];
  };


  services.xserver.desktopManager.gnome.extraGSettingsOverrides = ''
    [com.ubuntu.login-screen]
    background-picture-uri='file://${./nixos-wallpaper-catppuccin-frappe.png}'
  '';
}
