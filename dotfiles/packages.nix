{ pkgs, lib, ... }: {
  nixpkgs.config.allowUnfree = true;

  # Enable flakes and nix-command
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable gnupg
  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-gnome3;
  };

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
  programs.nix-ld.libraries = with pkgs; [];

  # Environment packages
  environment.systemPackages = with pkgs; [
    # Essential
    oh-my-posh
    fastfetch
    librewolf
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
    rust-analyzer
    zed-editor
    python311
    rustup
    gcc

    # Other
    gnome-tweaks
    parabolic
    clapper
    ffmpeg
    folio
    btop
    warp
    xsel

    nixd
    nil

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
  environment.sessionVariables.GST_PLUGIN_SYSTEM_PATH_1_0 =
    lib.makeSearchPathOutput "lib" "lib/gstreamer-1.0" (with pkgs.gst_all_1; [
      gst-plugins-good
      gst-plugins-bad
      gst-plugins-ugly
      gst-libav
    ]);
}
