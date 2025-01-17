{ config, pkgs, lib, ... }: {
  programs.dconf.enable = true;
  
  home.username = "gemini";
  home.homeDirectory = "/home/gemini";
  
  # Kanata configuration
  hardware.uinput.enable = true; # Needed for Kanata to work!
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
