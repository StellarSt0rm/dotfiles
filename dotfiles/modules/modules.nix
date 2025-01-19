{ ... }: {
  imports = [
    #./zen.nix
  ];
  
  home-manager.users.gemini = {
    imports = [
      #./waybar/waybar.nix
      ./gnome/gnome.nix
    ];
    
    home.username = "gemini";
    home.homeDirectory = "/home/gemini";
  };
}
