{ config, ... }: {
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
}
