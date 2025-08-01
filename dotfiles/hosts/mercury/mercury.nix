{ pkgs, ... }: {
  imports = [ ./mercury-hardware.nix ];

  # Extra packages/extensions
  environment.systemPackages = with pkgs; [
    (bottles.override { removeWarningPopup = true; })
    #gnomeExtensions.paperwm
  ];

  home-manager.users.gemini.dconf.settings = {
    "org/gnome/mutter".experimental-features = [ "scale-monitor-framebuffer" "xwayland-native-scaling" ]; # Enable fractional scaling

    #"org/gnome/shell".enabled-extensions = [
    #  pkgs.gnomeExtensions.paperwm.extensionUuid
    #];
  };

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
  
  # Enable and configure Kanata
  services.kanata = {
    enable = true;

    keyboards.default.config = ''
      ;; Map RCtrl to Menu key
      (defsrc
        rctrl
      )

      (deflayer base
        menu
      )
    '';
  };
}
