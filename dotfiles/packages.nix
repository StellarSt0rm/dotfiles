{ config, ... }: {
  nixpkgs.config.allowUnfree = true;
  
  # Enable flakes and nix-command
  nix.settings.experimental-features = [ "nix-command", "flakes" ];
  
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
  
  # Environment packages
  environment.systemPackages = with pkgs; [
    fuzzel
    waybar
    
    # Essential
    oh-my-posh
    fastfetch
    fish
    xsel
    git
    gh
    
    # GTK
    gnome.dconf-editor
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
    ffmpeg
    btop
    xsel
    
    # Themes
    #papirus-icon-theme
    #bibata-cursors
  ];
}
