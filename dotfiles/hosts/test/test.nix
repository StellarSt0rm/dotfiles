{ ... }: {
  imports = [ ./test-hardware.nix ];
  
  networking.hostName = "test";
  system.stateVersion = "24.11";

  home-manager.users.gemini.home.stateVersion = "24.11";
}
