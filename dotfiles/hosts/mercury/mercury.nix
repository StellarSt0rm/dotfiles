{ ... }: {
  imports = [ ./mercury-hardware.nix ];

  networking.hostName = "mercury";
  system.stateVersion = "24.11";

  home-manager.users.gemini.home.stateVersion = "24.11";
  programs.git.config.user.signingKey = "7DA370CED46BF6E268A290F4DEBBC746017C00B3";

  # Improve battery life
  powerManagement = {
    enable = true;
    powertop.enable = true;
  };

  # Enable amdgpu drivers
  services.xserver.videoDrivers = [ "amdgpu" ];
  boot.initrd.kernelModules = [ "amdgpu" ];

  # Enable touchpad support
  services.libinput.enable = true;
}
