{ config, pkgs, ... }: {
  imports = [ ./starlight-hardware.nix ];

  networking.hostName = "starlight";
  system.stateVersion = "24.11";

  home-manager.users.gemini.home.stateVersion = "24.11";
  programs.git.config.user.signingKey = "0CD71823FAFF0DAAEFAFEA6AE4607894190C2177";

  # Nvidia fuckery
  boot.kernelParams = [ "nvidia-drm.modeset=1" "module_blacklist=i915" ];
  hardware.graphics.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  nixpkgs.config.nvidia.acceptLicense = true;

  hardware.nvidia = {
    modesetting.enable = true;
    open = false;
    nvidiaSettings = true;

    powerManagement.enable = false;
    powerManagement.finegrained = false;

    package = config.boot.kernelPackages.nvidiaPackages.stable;
    prime = {
      offload.enable = false;
      sync.enable = false;

      nvidiaBusId = "PCI:0:2:0";
      intelBusId = "PCI:0:0:2";
    };
  };

  # Fix issue with suspend
  #systemd.services."systemd-suspend" = {
  #  serviceConfig = {
  #    Environment=''"SYSTEMD_SLEEP_FREEZE_USER_SESSIONS=false"'';
  #  };
  #};

  # Extra packages
  environment.systemPackages = with pkgs; [
    # Tools
    blender
    gimp
    godot_4
    easytag

    # Other
    virt-manager
    qemu
  ];

  # Set extra Librewolf settings
  home-manager.users.gemini.programs.librewolf.profiles.gemini.settings = {
    "mousewheel.default.delta_multiplier_y" = 250;
    "mousewheel.min_line_scroll_amount" = 15;
  };

  # Set games SSD mount point
  fileSystems."/mnt/games" = {
    device = "/dev/disk/by-label/games";
    fsType = "auto";
    options = [ "nosuid" "nodev" "nofail" "x-gvfs-show" ];
  };

  # Disable kanata, this host does have a Menu key.
  services.kanata.enable = false;
}
