{ ... }: {
  imports = [ ./mercury-hardware.nix ];

  networking.hostName = "mercury";
  system.stateVersion = "24.11";

  home-manager.users.gemini.home.stateVersion = "24.11";

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
