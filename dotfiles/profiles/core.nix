{ pkgs, lib, host-system, ... }: {
  system.stateVersion = host-system.initial-version;
  networking.hostName = host-system.hostname;

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable GPG agent and Gnome Keyring
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;

    pinentryPackage = pkgs.pinentry-gnome3;
  };

  services.gnome.gnome-keyring.enable = true;
  environment.etc."xdg/autostart/gnome-keyring-ssh.desktop".text = ''
    [Desktop Entry]
    Type=Application
    Hidden=true
  '';

  # Enable GNOME and GDM
  services.xserver = {
    enable = true;
    displayManager.gdm = {
      enable = true;
      wayland = true;

      banner = "Overthrow The Government!";
      settings.greeter.exclude = "root";
    };
    desktopManager.gnome.enable = true;
  };

  services.displayManager.defaultSession = "gnome";

  # NixLD
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = [];

  # System packages
  environment.systemPackages = with pkgs; [
    # Essential
    mission-center
    librewolf
    parabolic # Media Downloader
    clapper # Video Player
    gapless # Music Player : g4music
    gradia # Photo Editor
    folio # Notes
    warp # File tranfsers

    # CLI
    fishPlugins.autopair
    oh-my-posh
    fastfetch
    fortune
    fish
    xsel # Clipboard tool
    fzf
    fd

    # Tools
    python311
    ffmpeg
    btop
    git
    gh

    # Other
    gnome-tweaks
    dconf-editor
    p7zip
    kooha

    # Nix
    nixd
    nil

    # Themes
    qadwaitadecorations
    qadwaitadecorations-qt6
    papirus-icon-theme
    bibata-cursors
    adw-gtk3
    gtk4
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
    app-hider
    caffeine
  ]);

  # Exclude unneeded packages
  environment.gnome.excludePackages = (with pkgs; [
    gnome-shell-extensions
    gnome-system-monitor
    gnome-connections
    gnome-contacts
    gnome-weather
    gnome-music
    simple-scan
    gnome-maps
    gnome-tour
    epiphany
    evince
    totem
    yelp
  ]);

  services.xserver.excludePackages = [ pkgs.xterm ];

  # Systemd optimizations
  systemd.services."NetworkManager-wait-online".enable = false;

  services.journald.extraConfig = ''
    SystemMaxUse=50M
    RuntimeMaxUse=100M

    ForwardToSyslog=no
    ForwardToKMsg=no

    MaxRetentionSec=1w
  '';

  # Install NerdFonts
  fonts.packages = with pkgs; [
    maple-mono.variable
    nerd-fonts.symbols-only
  ];

  # Autoclean old generations
  nix.gc = {
    automatic = true;
    persistent = true;
    
    dates = "Sat 12:00";
    options = "--delete-older-than 5d";
  };

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Fix GStreamer Plug-in Issue
  environment.sessionVariables.GST_PLUGIN_SYSTEM_PATH_1_0 =
    lib.makeSearchPathOutput "lib" "lib/gstreamer-1.0" (with pkgs.gst_all_1; [
      gst-plugins-good
      gst-plugins-bad
      gst-plugins-ugly
      gst-libav
    ]);

  # Set QT theme
  environment.variables.QT_WAYLAND_DECORATION = "adwaita";
}
