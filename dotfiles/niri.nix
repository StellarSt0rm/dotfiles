{ config, pkgs, inputs, ... }: {
  imports = [ inputs.niri.homeModules.niri ];

  programs.niri.enable = true;
  programs.niri.config = ''
    switch-events.lid-close { spawn "${pkgs.systemd}/bin/loginctl" "lock-session"; }
    
    // Workspaces
    workspace "coding"
    workspace "research"
    
    // Inputs
    input {
      focus-follows-mouse max-scroll-amount="25%"
      
      touchpad {
        tap
        natural-scroll
        click-method "clickfinger"
      }
    }
    
    // Keybinds
    binds = {
      // Spawning
      Super+Q { spawn "${pkgs.gnome-console}/bin/kgx"; }
      Super+E { spawn "${pkgs.zed-editor}/bin/zed"; }
      Super+R { spawn "${pkgs.nautilus}/bin/nautilus" }
      Super+F { spawn "${pkgs.firefox}/bin/firefox"; }
      Super+L { spawn "${pkgs.systemd}/bin/loginctl" "lock-session"; }
      
      // Destructive actions
      Alt+Q { close-window; }
      
      // Other
      Ctrl+Shift+Escape { spawn "${mission-center}/bin/missioncenter"; }
      Print { screenshot; }
    }
    
    // Layout
    layout {
      gaps 16
      
      border.off
      focus-ring {
        width 2
        active-gradient from="#a8d8ff" to="#e0f7ff" angle=45 relative-to="workspace-view"
      }
      
      struts { left 32; right 32; }
    }
  '';
}
