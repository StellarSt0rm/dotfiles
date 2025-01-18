{ lib, ... }: {
  imports = [
    ./extensions.nix
    ./apps.nix
    ./keybinds.nix
  ];
  
  dconf.settings = with lib.hm.gvariant; {
    "org/gnome/shell/app-switcher".current-workspace-only = true;
    "org/gnome/shell/window-switcher".current-workspace-only = true;
    "org/gnome/desktop/privacy".remove-old-temp-files = true;
    
    "org/gnome/mutter" = {
      workspaces-on-primary-only = true;
      center-new-windows = true;
      dynamic-workspaces = true;
      edge-tiling = false;
    };
    
    "org/gnome/desktop/wm/preferences" = {
      button-layout = "appmenu:close";
      focus-mode = "sloppy";
      audible-bell = false;
    };
    
    "org/gnome/desktop/peripherals/touchpad" = {
      disable-while-typing = false;
      tap-to-click = true;
    };
    
    "org/gnome/desktop/search-providers" = {
      disabled = [
        "org.gnome.seahorse.Application.desktop"
        "org.gnome.Characters.desktop"
        "org.gnome.Epiphany.desktop"
        "org.gnome.Nautilus.desktop"
        "org.gnome.Settings.desktop"
        "org.gnome.clocks.desktop"
      ];
      sort-order = [ "org.gnome.Calculator.desktop" "org.gnome.Calendar.desktop" ];
    };
    
    # Interface
    "org/gnome/desktop/background".picture-uri-dark  = "file://${toString ./nixos-wallpaper-catppuccin-frappe.png}";
    "org/gnome/desktop/screensaver" = {
      picture-uri = "file://${toString ./nixos-wallpaper-catppuccin-frappe.png}";
      show-full-name-in-top-bar = false;
      user-switch-enabled = false;
    };
    
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      cursor-theme = "Bibata-Modern-Ice";
      icon-theme = "Papirus-Dark";
      
      enable-hot-corners = false;
      gtk-enable-primary-paste = false;
      show-battery-percentage = true;
      
      gtk-theme = "adw-gtk3-dark";
      accent-color = "purple";
    };
    
    "org/gnome/desktop/sound" = {
      event-sounds = false;
      theme-name = "__custom";
    };
  };
}
