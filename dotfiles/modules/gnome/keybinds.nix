{ lib, ... }: {
  dconf.settings = with lib.hm.gvariant; {
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/terminal" = {
      binding = "<Super>q";
      command = "kgx";
      name = "Terminal (kgx)";
    };
    
    "org/gnome/settings-daemon/plugins/media-keys/custom/keybindings/zed-editor" = {
      binding = "<Super>e";
      command = "zed";
      name = "Zen Editor";
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/system-monitor" = {
      binding = "<Control><Shift>Escape";
      command = "missioncenter";
      name = "System Monitor";
    };
        
    "org/gnome/settings-daemon/plugins/media-keys".custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/terminal/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/zed-editor/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/system-monitor/"
    ];
    
    "org/gnome/settings-daemon/plugins/media-keys" = {
      home = [ "<Super>r" ];
      www = [ "<Super>f" ];
    };
    
    "org/gnome/desktop/wm/keybindings" = {
      begin-move = [ "<Super>z" ];
      begin-resize = [ "<Super>x" ];
      close = [ "<Alt>q" ];
    };
    
    "org/gnome/shell/keybindings" = {
      show-screenshot-ui = [ "<Shift><Super>s" "Print" ];
      toggle-message-tray = [ "<Super>v" ];
    };
  };
}
