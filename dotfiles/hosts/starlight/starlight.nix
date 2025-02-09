{ ... }: {
  imports = [ ./starlight-hardware.nix ];
  
  networking.hostName = "starlight";
  system.stateVersion = "24.11";
  
  home-manager.users.gemini.home.stateVersion = "24.11";
  programs.git.user.signingKey = "0CD71823FAFF0DAAEFAFEA6AE4607894190C2177";

  # Install Steam
  programs.steam.enable = true;
}
