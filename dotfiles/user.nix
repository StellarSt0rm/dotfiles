{ config, pkgs, ... }: {
  users.users.gemini = {
    isNormalUser = true;
    
    home = "/home/gemini";
    shell = pkgs.fish;
    
    extraGroups = [ "wheel", "networkManager" ];
  };
}
