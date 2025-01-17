# https://github.com/RoastBeefer00/nix-home/blob/main/nix_modules/waybar.nix
# https://github.com/Alexays/Waybar/wiki/Configuration

# TODO:
# https://github.com/elifouts/Dotfiles/blob/main/.config/waybar/style.css
# https://github.com/Alexays/Waybar/wiki/Module:-MPRIS

{ ... }: {
  programs.waybar = {
    settings = [{
      layer = "top";
      position = "top";
      mode = "dock";
      
      exclusive = true;
      passthrough = false;
      gtk-layer-shell = true;
      
      # Layout
      modules-left = [
        "niri/workspaces"
        "custom/divider"
        "cpu"
        "memory"
      ];
      
      modules-center = [
        "clock"
      ];
      
      modules-right = [
        "tray"
        "network"
        "custom/divider"
        "idle_inhibitor"
        "wireplumber"
        "battery"
      ];
      
      # Custom + Clock
      "custom/divider" = {
        format = " | ";
        interval = "once";
        tooptip = false;
      };
      
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
          on-scroll-up = "tz_up";
          on-scroll-down = "tz_down";
          
          on-scroll-up = "shift_up";
          on-scroll-down = "shift-down";
        };
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
      
      cpu = {
        format = " {usage}%"; # nf-oct-cpu
      };
      
      memory = {
        format = " {pergentage}%"; # nf-fa-memory
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
    }];
  };
}
