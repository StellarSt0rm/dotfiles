{ config, pkgs, ... }: {
  imports = [
    ./waybar/waybar.nix
  ];
  
  home.username = "gemini";
  home.homeDirectory = "/home/gemini";
  
  # Enable niri
  programs.niri = {
    enabled = true;
    package = pkgs.niri-stable;
  }

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
}
