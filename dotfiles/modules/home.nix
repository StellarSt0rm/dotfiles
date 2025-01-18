{ config, pkgs, ... }: {
  imports = [
    #./waybar/waybar.nix
    ./gnome/gnome.nix
  ];
  
  home.username = "gemini";
  home.homeDirectory = "/home/gemini";

  # Fix errors when package is not installed
  programs.nix-index = {
    enable = true;
    enableFishIntegration = true;
  };
}
