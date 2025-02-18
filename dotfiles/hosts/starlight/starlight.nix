{ config, pkgs, ... }: {
  imports = [ ./starlight-hardware.nix ];

  networking.hostName = "starlight";
  system.stateVersion = "24.11";

  home-manager.users.gemini.home.stateVersion = "24.11";
  programs.git.config.user.signingKey = "0CD71823FAFF0DAAEFAFEA6AE4607894190C2177";

  # Nvidia fuckery
  boot.kernelParams = [ "nvidia-drm.modeset=1" ];
  hardware.graphics.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;
    open = false;
    nvidiaSettings = true;

    package = config.boot.kernelPackages.nvidiaPackages.stable;
    prime = {
      nvidiaBusId = "PCI:0:2:0";
      intelBusId = "PCI:0:0:2";
    };
  };

  # Fix issue with suspend
  systemd.services."systemd-suspend" = {
    serviceConfig = {
      Environment=''"SYSTEMD_SLEEP_FREEZE_USER_SESSIONS=false"'';
    };
  };

  # Install extra packages
  programs.steam = {
    enable = true;
    protontricks.enable = true;
    localNetworkGameTransfers.openFirewall = true;

    package = pkgs.steam.override {
      extraPkgs = pkgs: with pkgs; [
        bibata-cursors
      ];
    };
  };

  environment.systemPackages = with pkgs; [
    # Games
    bottles
    prismlauncher

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
}
