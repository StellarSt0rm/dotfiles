{ config, pkgs, ... }: {
  imports = [
    #./waybar/waybar.nix
    ./gnome/gnome.nix
  ];
  
  home.username = "gemini";
  home.homeDirectory = "/home/gemini";
