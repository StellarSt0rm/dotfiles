{ lib, ... }: {
  dconf.settings = with lib.hm.gvariant; {
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
      
      maximize = [ "<Super>Up" ];
      unmaximize = [ "<Super>Down" ];
    };
    
    "org/gnome/shell/keybindings" = {
      show-screenshot-ui = [ "<Shift><Super>s" "Print" ];
      toggle-message-tray = [ "<Super>v" ];
    };
  };
}
