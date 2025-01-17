{ config, pkgs, ... }: {
  imports = [
    ./waybar/waybar.nix
  ];
  
  home.username = "gemini";
  home.homeDirectory = "/home/gemini";
  
  # Enable niri
#  programs.niri = {
#    enable = true;
#    package = pkgs.niri-stable;
#  };
}
