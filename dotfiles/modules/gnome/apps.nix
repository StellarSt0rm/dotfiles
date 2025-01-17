{ lib, ... }: {
  dconf.settings = with lib.hm.gvariant; {
    "org/gnome/nautilus/preferences".show-create-link = true;
    
    "org/gnome/Console" = {
      last-window-size = (mkTuple [790 500]);
      last-window-maximised = false;
      audible-bell = false;
      visual-bell = false;
    };
  };
}
