# https://github.com/RoastBeefer00/nix-home/blob/main/nix_modules/waybar.nix
# https://github.com/Alexays/Waybar/wiki/Configuration

{ ... }: {
  programs.waybar = {
    settings = [{
      layer = "top";
      position = "top";
      mode = "dock";
      
      exclusive = true;
      passthrough = false;
      gtk-layer-shell = true;
      
      style = "${toString ./style.css}";
      
      # Layout
      modules-left = [
        "niri/workspaces"
        "custom/divider"
        "mpris"
      ];
      
      modules-center = [
        "clock"
      ];
      
      modules-right = [
        "tray"
        "idle_inhibitor"
        "custom/divider"
        "network"
        "wireplumber"
        "battery"
        "group/power"
      ];
      
      # Other
      "custom/divider" = {
        format = " | ";
        interval = "once";
        tooltip = false;
      };
      
      # Left modules
      "niri/workspaces" = {
        format = "{icon}";
        format-icons = {
          coding = ""; # nf-fa-laptop_code
          research = "󰜏"; # nf-md-search_web
          
          active = ""; # nf-oct-dot_fill
          default = ""; # nf-oct-dot
        };
      };

      "mpris" = {
        player = "gapless";

        format = "{status_icon} {title} - {artist}";
        format-stopped = "";
        status-icons = {
          playing = "󰝚"; # nf-md-music
          paused = "󰏤"; # nf-md-pause
        };
      };
      
      # Center Modules
      clock = {
        format = "{%b %d  %H:%M} 󱑒"; # nf-md-clock_time_eight_outline
        tooltip-format = "<tt><small>{calendar}</small></tt>";
        
        calendar = {
          mode = "month";
          on-scroll = 1;
          
          format = {
            months = "<span color='#ffead3'><b>{}</b></span>";
            days = "<span opacity='0.6'><b>{}</b></span>";
            weekdays = "<span color='#ffcc66'><b>{}</b></span>";
            today = "<span color='#ecc6d9'><b>{}</b></span>";
          };
        };
        
        actions = {
          on-scroll-up = "shift_up";
          on-scroll-down = "shift-down";
        };
      };
      
      # Right modules
      tray = {
        icon-size = 20;
        spacing = 5;
      };
      
      network = {
        format-ethernet = "󰈀"; # nf-md-ethernet
        format-disconnected = "";
        format-icons = [ "󰤟" "󰤢" "󰤥" "󰤨" ]; # nf-md-wifi_strength_n
        
        tooltip-format = "{ifname} / {cidr}";
        tooltip-wifi = "{signalStrength} | {ifname} / {cidr}";
        tooltip-disconnected = "Disconnected";
      };
      
      idle_inhibitor = {
        format = "{icon}";
        format-icons = {
          activated = "󰒳"; # nf-md-sleep_off
          deactivated = "󰒲"; # nf-md-sleep
        };
        
        tooltip-format-activated = "Sleep Inhbibitor Is Active";
        tooltip-format-deactivated = "Sleep Inhibitor Is Inactive";
      };
      
      wireplumber = {
        format = "{icon}";
        format-muted = "󰖁"; # nf-md-volume_off
        format-icons = [ "󰕿" "󰖀" "󰕾" ]; # nf-md-volume_n
        
        tooltip-format = "Volume: {volume}%";
      };
      
      battery = {
        format = "{icon} {capacity}%";
        states = {
          alert = 0;
          twenty = 20;
          forty = 40;
          sixty = 60;
          eighty = 80;
          full = 100;
        };
        format-icons = [ "󱃍" "󰁻" "󰁽" "󰁿" "󰂁" "󰁹"]; # nf-mf-battery
        
        tooltip-format = "Time ultil full/empty: {time}";
        format-time = "{H} hours, {M} minutes";
      };
      
      "group/power" = {
        orientation = "inherit";
        drawer.transition-duration = 500;
        
        modules = [ "custom/power" "custom/logout" "custom/lock" ];
      };
      
      # Group/power modules
      "custom/power" = {
        format = ""; # nf-fa-power_off
        tooltip = false;
        on-click = "gnome-session-quit --power-off";
      };
      
      "custom/logout" = {
        format = "󰗽"; # nf-md-logout_variant
        tooltip = false;
        on-click = "gnome-session-quit --logout";
      };
      
      "custom/lock" = {
        format = "󰌾"; # nf-md-lock
        tooltip = false;
        on-click = "gnome-screensaver-command --lock";
      };
    }];
  };
}
