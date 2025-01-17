{ lib, ... }: {
  import = [
    ./extensions.nix
    #./apps.nix
    #./keybinds.nix
  ];
  
  dconf.settings = with lib.hm.gvariant; {
    "org/gnome/shell/app-switcher".current-workspace-only = true;
    "org/gnome/shell/window-switcher".current-workspace-only = true;
    
    "org/gnome/mutter".center-new-windows = true;
    "org/gnome/desktop/wm/preferences".focus-mode = "sloppy";
    
    "org/gnome/desktop/privacy".remove-old-temp-files = true;
    
    "org/gnome/desktop/peripherals/touchpad" = {
      disable-while-typing = false;
      tap-to-click = true;
    };
    
    # Interface
    "org/gnome/desktop/background".picture-uri  = "file://${toString ./nixos-wallpaper-catppuccin-frappe.png}";
    "org/gnome/desktop/screensaver".picture-uri = "file://${toString ./nixos-wallpaper-catppuccin-frappe.png}";
  };
}
