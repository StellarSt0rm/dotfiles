{ config, pkgs, lib, ... }: {
  nixpkgs.config.allowUnfree = true;
  
  # Enable flakes and nix-command
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  
  # Enable GNOME and GDM
  services.xserver = {
    enable = true;
    displayManager.gdm = {
      enable = true;
      wayland = true;
    };
    desktopManager.gnome.enable = true;
  };
  
#  services.displayManager.defaultSession = "niri";
  
  # Enable and configure git
  programs.git = {
    enable = true;
    
    config = {
      "credential \"https://github.com\"" = {
        helper = "!/run/current-system/sw/bin/gh auth git-credential";
      };
      "credential \"https://gist.github.com\"" = {
        helper = "!/run/current-system/sw/bin/gh auth git-credential";
      };
      
      user = {
        email = "StellarSt0rm@proton.me";
        name = "StellarSt0rm";
      };
    };
  };

  # Kanata configuration
  services.kanata = {
    enable = true;
    
    keyboards.default.config = ''
      ;; Map RCtrl to Menu key
      (defsrc
        rctrl
      )
      
      (deflayer base
        menu
      )
    '';
  };

  # Enable dconf
  programs.dconf.enable = true;
  
  # Environment packages
  environment.systemPackages = with pkgs; [
    librewolf
    
    # Essential
    oh-my-posh
    fastfetch
    fish
    xsel
    git
    gh
    
    # GTK
    dconf-editor
    mission-center
    adw-gtk3
    gapless #g4music
    gtk4
    
    # Coding
    fishPlugins.autopair
    zed-editor
    python311
    rustup
    
    # Other
    gnome-tweaks
    ffmpeg
    btop
    xsel
    
    # Themes
    papirus-icon-theme
    bibata-cursors
  ] ++ (with pkgs.gnomeExtensions; [
    clipboard-indicator
    tiling-assistant
    just-perfection
    burn-my-windows
    blur-my-shell
    appindicator
    dash-to-dock
    mpris-label
    alttab-mod
    pip-on-top
    caffeine
  ]);
  
  # Exclude unneeded packages
  environment.gnome.excludePackages = (with pkgs; [
  	gnome-shell-extensions
  	gnome-system-monitor
  	gnome-contacts
  	gnome-music
  	simple-scan
  	gnome-maps
  	gnome-tour
  	epiphany
  	evince
  	yelp
  ]);
  
  services.xserver.excludePackages = [ pkgs.xterm ];
  
  # Install NerdFonts
  fonts.packages = with pkgs; [
    maple-mono
    (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
  ];

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  
  # Fix GStreamer Plug-in Issue
  environment.sessionVariables.GST_PLUGIN_SYSTEM_PATH_1_0 = lib.makeSearchPathOutput "lib" "lib/gstreamer-1.0" (with pkgs.gst_all_1; [
    gst-plugins-good
    gst-plugins-bad
    gst-plugins-ugly
    gst-libav
  ]);
  
  # Enable sudo inults
  security.sudo.package = pkgs.sudo.override { withInsults = true; };
  security.sudo.extraConfig = "Defaults insults";
}
