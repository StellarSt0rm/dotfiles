{ host-system, ... }: {
  home-manager.users.gemini = {
    imports = [
      ./gnome/gnome.nix
      ./librewolf/librewolf.nix

      #./waybar/waybar.nix
    ];

    home.username = "gemini";
    home.homeDirectory = "/home/gemini";
    home.stateVersion = host-system.initial-version;
  };
}
