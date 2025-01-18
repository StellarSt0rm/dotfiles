{ config, pkgs, lib, ... }:
let
  emoji-copy-patch = pkgs.gnomeExtensions.emoji-copy.overrideAttrs (old: rec {
    src = pkgs.fetchurl {
      url = "https://github.com/FelipeFTN/Emoji-Copy/releases/download/v2.2.0/emoji-copy@felipeftn.zip";
      hash = "sha256-q/lWFME2oH2VeMlai5qRE60JTuCa4Bzh18ponTEG7pU=";
      downloadToTemp = true;
      recursiveHash = true;
      
      postFetch = ''
        ${pkgs.unzip}/bin/unzip $downloadedFile -d $out
      '';
    };
  });
in {
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  
  # Enable Needed Packages
  programs.steam.enable = true;
  programs.fish.enable = true;
  
  # Enable and configure flatpak
  services.flatpak.enable = true;
  
  systemd.services.flatpak-repo = {
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.flatpak ];
    script = ''
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    '';
  };
  
  # Enviroment Packages
  environment.systemPackages = with pkgs; [
    # Essentials
    oh-my-posh
    neovim
    btop
    fish
    xsel
    git
    gh
    
    python311
    ffmpeg
    unrar
    
    # Games
    wineWowPackages.staging
    prismlauncher
    
    # Gnome
    gnome3.gnome-tweaks
    gnome.dconf-editor
    mission-center
    libnotify
    glib.dev
    adw-gtk3
    g4music
    gtk4
    
    zed-editor
    
    # Gnome Extensions
    gnomeExtensions.quick-settings-tweaker
    gnomeExtensions.clipboard-indicator
    gnomeExtensions.tiling-assistant
    gnomeExtensions.just-perfection
    gnomeExtensions.burn-my-windows
    gnomeExtensions.add-to-desktop
    gnomeExtensions.blur-my-shell
    gnomeExtensions.appindicator
    gnomeExtensions.dash-to-dock
    gnomeExtensions.mpris-label
    gnomeExtensions.alttab-mod
    gnomeExtensions.pip-on-top
    gnomeExtensions.app-hider
    gnomeExtensions.caffeine
    
    emoji-copy-patch # Patched Emoji-Copy Version 🥳
    
    # Fish Plugins
    fishPlugins.autopair

    # Themes
    papirus-icon-theme
    bibata-cursors
  ];
  
  # Install NerdFonts
  fonts.packages = with pkgs; [
    maple-mono
    (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
  ];
  
  # Exclude Unneeded Packages
  environment.gnome.excludePackages = with pkgs.gnome; [
  	gnome-shell-extensions
  	gnome-system-monitor
  	pkgs.gnome-tour
  	gnome-contacts
  	gnome-music
  	simple-scan
  	gnome-maps
  	epiphany
  	evince
  	yelp
  ];
  
  services.xserver.excludePackages = [ pkgs.xterm ];
  
  # Enable Sudo Inults
  security.sudo.package = pkgs.sudo.override { withInsults = true; };
  security.sudo.extraConfig = "Defaults insults";
}
