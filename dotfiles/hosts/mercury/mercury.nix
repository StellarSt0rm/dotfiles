{ ... }: {
  imports = [ ./mercury-hardware.nix ];

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
