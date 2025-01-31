# https://discourse.nixos.org/t/gdm-background-image-and-theme/12632/10

{ config, pkgs, ... }: {
  nixpkgs = {
    overlays = [
      (self: super: {
        gnome = super.gnome.overrideScope (selfg: superg: {
          gnome-shell = superg.gnome-shell.overrideAttrs (old: {
            patches = (old.patches or []) ++ [
              (pkgs.writeText "bg.patch" ''
                --- a/data/theme/gnome-shell-sass/widgets/_login-lock.scss
                +++ b/data/theme/gnome-shell-sass/widgets/_login-lock.scss
                @@ -15,6 +15,7 @@ $_gdm_dialog_width: 23em;
                 /* Login Dialog */
                 .login-dialog {
                   background-color: $_gdm_bg;
                +  background-image: url('file://${toString ./nixos-wallpaper-catppuccin-frappe.png}');
                 }

                 // buttons
              '')
            ];
          });
        });
      })
    ];
  };
}
