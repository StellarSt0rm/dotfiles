{ lib, pkgs, ... }:
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
    "org/gnome/shell".enabled-extensions = with pkgs.gnomeExtensions; [
      clipboard-indicator.extensionUuid
      tiling-assistant.extensionUuid
      just-perfection.extensionUuid
      burn-my-windows.extensionUuid
      blur-my-shell.extensionUuid
      appindicator.extensionUuid
      dash-to-dock.extensionUuid
      mpris-label.extensionUuid
      alttab-mod.extensionUuid
      pip-on-top.extensionUuid
      app-hider.extensionUuid
      caffeine.extensionUuid
    ];
    
    # General config
    "org/gnome/shell/extensions/burn-my-windows".active-profile = "${burn-my-windows-profile}";
    "org/gnome/shell/extensions/altTab-mod".raise-first-instance-only = true;
    "org/gnome/shell/extensions/pip-on-top".stick = true;
    
    "org/gnome/shell/extensions/caffeine" = {
      show-indicator = "only-active";
      restore-state = true;

      duration-timer = 2;
	  show-timer = false;
    };
    
    "org/gnome/shell/extensions/clipboard-indicator" = {
      disable-dowm-arrow = true;
      display-mode = 0; # Icon
      
      cache-only-favorites = true;
      history-size = 30;
      
      keep-selected-on-clear = true;
      confirm-clear = true;
    };
    
    "org/gnome/shell/extensions/app-hider".hidden-apps = [
      "fish.desktop"
      "btop.desktop"
      "nixos-manual.desktop"
      
      "ca.desrt.dconf-editor.desktop"
      "org.gnome.seahorse.Application.desktop"
      "org.gnome.Console.desktop"
    ];
    
    # Blur my shell
    "org/gnome/shell/extensions/blur-my-shell/panel" = {
      ublur-in-overview = true;
      blur = true;
    };
    
    "org/gnome/shell/extensions/blur-my-shell/overview" = {
      style-components = 1;
      blur = true;
    };
    
    "org/gnome/shell/extensions/blur-my-shell/dash-to-dock" = {
      override-background = true;
      blur = true;
    };
    
    # Just perfection
    "org/gnome/shell/extensions/just-perfection" = {
      theme = false; # Do not override theme
      
      accessibility-menu = false;
      keyboard-layout = false;
      world-clock = false;
      weather = false;
      osd = false;
      
      window-demands-attention-focus = false;
      quick-settings-dark-mode = false;
    };
    
    # MPRIS Label
    "org/gnome/shell/extensions/mpris-label" = {
      # Looks
      mpris-sources-whitelist = "Gapless";
      use-whitelisted-sources-only = true;
      symbolic-source-icon = true;
      use-album = false;
      
      extension-place = "left";
      show-icon = "left";
      right-padding = 0;
      left-padding = 0;
      
      first-field = "xesam:title";
      second-field = "xesam:artist";
      last-field = "";
      max-string-length = 20;
      
      volume-control-scheme = "application";
      
      # Actions
      enable-double-clicks = true;
      left-click-action = "play-pause";
      middle-click-action = "volume-mute";
      right-click-action = "activate-player";
      
      left-double-click-action = "next-track";
      right-double-click-action = "prev-track";
      
      thumb-backward-action = "prev-track";
      thumb-forward-action = "next-track";
      scroll-action = "volume-controls";
      
      # Format
      remove-text-when-paused = false;
      button-placeholder = "";
      divider-string = " – ";
    };
    
    # Dash to dock
    "org/gnome/shell/extensions/dash-to-dock" = {
      # Behavior
      autohide = true;
      intellihide = true;
      intellihide-mode = "FOCUS_APPLICATION_WINDOWS";
      
      require-pressure-to-show = true;
      show-dock-urgent-notify = true;
      
      hot-keys = false;
      click-action = "minimize";
      middle-click-action = "launch";
      
      shift-click-action = "quit";
      shift-middle-click-action = "quit";
      scroll-action = "cycle-windows";
      
      # Looks
      apply-custom-theme = true; # Built-in theme
      custom-theme-shrink = false;
      
      dock-position = "BOTTOM";
      dash-max-icon-size = 45;
      
      workspace-agnostic-urgent-windows = true;
      scroll-to-focused-application = true;
      show-windows-preview = true;
      show-mounts = false;
      show-trash = false;
      
      show-show-apps-button = true;
    };
    
    # Tiling assistant
    "org/gnome/shell/extensions/tiling-assistant" = {
      enable-raise-tile-group = true;
      enable-tiling-popup = true;
      
      focus-hint = 1;
      focus-hint-color = "rgb(98, 104, 128)"; # Background middle logo color
      
      single-screen-gap = 8;
      window-gap = 8;
      
      center-window = [ "<Super>c" ];
    };
  };
  
  # Save the burn my windows config
  systemd.user.tmpfiles.rules = [
    "L+ %h/.config/burn-my-windows/profiles/nix-profile.conf 0755 - - - ${burn-my-windows-profile}"
  ];
}
