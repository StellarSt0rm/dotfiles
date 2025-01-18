{ pkgs, lib, ... }: {
  imports = [
    ./extensions.nix
    ./apps-config.nix
  ];
  
  dconf.settings = with lib.hm.gvariant; {
    "org/gnome/shell" = {
      last-selected-power-profile = "power-saver";
      
      favorite-apps = [ "org.gnome.Nautilus.desktop" "firefox.desktop" "steam.desktop" "org.godotengine.Godot4.desktop"];
      enabled-extensions = [
        "caffeine@patapon.info" "add-to-desktop@tommimon.github.com" "app-hider@lynith.dev"
        "clipboard-indicator@tudmotu.com" "dash-to-dock@micxgx.gmail.com" "just-perfection-desktop@just-perfection"
        "mprisLabel@moon-0xff.github.com" "pip-on-top@rafostar.github.com" "tiling-assistant@leleat-on-github"
        "appindicatorsupport@rgcjonas.gmail.com" "blur-my-shell@aunetx" "alttab-mod@leleat-on-github"
        "burn-my-windows@schneegans.github.com" "quick-settings-tweaks@qwreey" "emoji-copy@felipeftn"
      ];
      
      disable-extension-version-validation = true;
    };
    
    "org/gnome/shell/app-switcher".current-workspace-only = true;
    "org/gnome/shell/window-switcher".current-workspace-only = true;
    
    # Desktop
    "org/gnome/desktop/background" = {
      picture-uri = "file:///etc/nixos/desktop/wallpaper.jpg";
      picture-uri-dark = "file:///etc/nixos/desktop/wallpaper.jpg";
      
      primary-color = "#3071AE";
      secondary-color = "#000000";
    };
    
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      #cursor-theme = "Bibata-Modern-Ice";
      icon-theme = "Papirus-Dark";
      
      enable-hot-corners = false;
      gtk-enable-primary-paste = false;
      show-battery-percentage = true;
      
      gtk-theme = "adw-gtk3-dark";
    };
    
    "org/gnome/desktop/peripherals/touchpad" = {
      disable-while-typing = false;
      tap-to-click = true;
    };
    
    "org/gnome/desktop/privacy".remove-old-temp-files = true;
    
    "org/gnome/desktop/screensaver" = {
      picture-uri = "file:///run/current-system/sw/share/backgrounds/gnome/adwaita-d.jpg";
      primary-color = "#3071AE";
      secondary-color = "#000000";
    };
    
    "org/gnome/desktop/search-providers" = {
      disabled = [
        "org.gnome.Settings.desktop" "org.gnome.Nautilus.desktop" "org.gnome.Characters.desktop" "org.gnome.clocks.desktop"
        "org.gnome.Epiphany.desktop" "org.gnome.seahorse.Application.desktop"
      ];
      sort-order = [ "org.gnome.Calculator.desktop" "org.gnome.Calendar.desktop" ];
    };
    
    "org/gnome/desktop/sound" = {
      event-sounds = false;
      theme-name = "__custom";
    };
    
    "org/gnome/mutter".center-new-windows = true;
    "org/gnome/desktop/wm/preferences" = {
      button-layout = "appmenu:close";
      focus-mode = "sloppy";
      audible-bell = false;
    };
    
    "org/gnome/desktop/input-sources" = {
      per-window = true;
      sources = [ (mkTuple ["xkb" "es+cat"]) /*(mkTuple ["xkb" "us"])*/ ];
    };
    
    # Keybinds
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Super>q";
      command = "kgx";
      name = "Terminal (kgx)";
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
      binding = "<Control><Shift>Escape";
      command = "missioncenter";
      name = "System Monitor";
    };
    
    "org/gnome/settings-daemon/plugins/media-keys".custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
    ];
    
    "org/gnome/settings-daemon/plugins/media-keys" = {
      home = [ "<Super>e" ];
      www = [ "<Super>f" ];
    };
    
    "org/gnome/desktop/wm/keybindings" = {
      begin-move = [ "<Super>z" ];
      begin-resize = [ "<Super>x" ];
      close = [ "<Alt>q" ];
      
      #maximize = [ "<Super>Up" ];
      #unmaximize = [ "<Super>Down" ];
    };
    
    "org/gnome/shell/keybindings" = {
      show-screenshot-ui = [ "<Shift><Super>s" "Print" ];
      toggle-message-tray = [ "<Super>v" ];
    };
  };
}
