{ pkgs, ... }: {
  imports = [ ./starlight-hardware.nix ];
  
  networking.hostName = "starlight";
  system.stateVersion = "24.11";
  
  home-manager.users.gemini.home.stateVersion = "24.11";
  programs.git.user.signingKey = "0CD71823FAFF0DAAEFAFEA6AE4607894190C2177";

  # Install extra packages
  programs.steam.enable = true;

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
}
