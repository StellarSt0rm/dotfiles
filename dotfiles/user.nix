{ config, ... }: {
  users.users.gemini = {
    isNormalUser = true;
    home = "/home/gemini";
    
    extraGroups = [ "wheel", "networkManager" ];
  };
}
