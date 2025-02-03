{ ... }: {
  home-manager.users.gemini = {
    imports = [
      #./waybar/waybar.nix

      ./gnome/gnome.nix
      ./librewolf/librewolf.nix
    ];

    home.username = "gemini";
    home.homeDirectory = "/home/gemini";
  };
}
