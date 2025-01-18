{ pkgs, lib, ... }:
let
  burn-my-windows-profile = pkgs.writeText "nix-profile.conf" ''
    [burn-my-windows-profile]
    fire-enable-effect=false
    glide-enable-effect=true
    glide-squish=0.15
    glide-shift=-0.25
    glide-scale=0.85
    glide-tilt=0.25
  '';
in {
  dconf.settings = with lib.hm.gvariant; {
    "org/gnome/shell/extensions/app-hider".hidden-apps = [ "fish.desktop" "nixos-manual.desktop" "nvim.desktop" ];
    "org/gnome/shell/extensions/burn-my-windows".active-profile = "${burn-my-windows-profile}";
    
    "org/gnome/shell/extensions/altTab-mod".raise-first-instance-only = true;
    
    "org/gnome/shell/extensions/blur-my-shell/dash-to-dock" = {
      override-background = true;
    };
    
    "org/gnome/shell/extensions/clipboard-indicator" = {
      cache-only-favorites = true;
      keep-selected-on-clear = true;
      
      topbar-preview-size = 1;
    };
    
    "org/gnome/shell/extensions/dash-to-dock" = {
      apply-custom-theme = true; # Disable when error with DEFAULT indicator is fixed
      intellihide-mode = "FOCUS_APPLICATION_WINDOWS";
      
      runner-indicator-style = "DEFAULT"; # Alt: DOTS
      background-opacity = 0.8;
      dash-max-icon-size = 45;
      height-fraction = 0.9;
      
      transparency-mode = "DYNAMIC";
      customize-alphas = true;
      max-alpha = 0.75;
      min-alpha = 0.0;
      
      click-action = "minimize";
      scroll-action = "cycle-windows";
      middle-click-action = "quit";
      shift-middle-click = "quit";
      
      show-mounts = false;
      show-trash = false;
      show-windows-preview = false;
      show-show-apps-button = true;
      
      hot-keys = false;
    };
    
    "org/gnome/shell/extensions/caffeine" = {
      show-timer = false;
      restore-state = true;
    };
    
    "org/gnome/shell/extensions/quick-settings-tweaks" = {
      add-dnd-quick-toggle-enabled = false;
      datemenu-remove-notifications = false;
      
      disable-adjust-content-border-radius = true;
      disable-remove-shadow = true;
      user-removed-buttons = [ "DarkModeToggle" ];
      
      media-control-enabled = false;
      notifications-enabled = false;
    };
    
    "org/gnome/shell/extensions/just-perfection" = {
      background-menu = false;
      window-menu-take-screenshot-button = false;
    
      world-clock = false;
      calendar = true;
      
      switcher-popup-delay = false;
      workspace-popup = true; /* Breaks dynamic workspaces when set to false */
    };
    
    "org/gnome/shell/extensions/mpris-label" = {
      symbolic-source-icon = true;
      use-album = false;
      
      extension-place = "left";
      reposition-delay = 0;
      
      left-padding = 0;
      right-padding = 0;
      icon-padding = 5;
      
      mpris-sources-whitelist = "G4Music";
      use-whitelisted-sources-only = true;
      auto-switch-to-most-recent = true;
      
      button-placeholder = "";
      divider-string = "  ―  ";
      remove-text-when-paused = false;
      
      first-field = "xesam:title";
      second-field = "xesam:artist";
      last-field = "";
      
      enable-double-clicks = true;
      left-click-action = "play-pause";
      middle-click-action = "volume-mute";
      
      left-double-click-action = "prev-track";
      right-double-click-action = "next-track";
    };
    
    "org/gnome/shell/extensions/emoji-copy" = {
      always-show = false;
      gender = 1;
    };
    
    "org/gnome/shell/extensions/tiling-assistant" = {
      dynamic-keybinding-behavior = 1;
      active-window-hint = 1;
      
      center-window = [ "<Super>c" ];
      single-screen-gap = 8;
      window-gap = 8;
    };
    
    "org/gnome/shell/extensions/appindicator".tray-pos = "left";
  };
  
  systemd.user.tmpfiles.rules = [
    # Set "Burn My Windows" Config
    "L+ %h/.config/burn-my-windows/profiles/nix-profile.conf 0755 - - - ${burn-my-windows-profile}"
  ];
}
