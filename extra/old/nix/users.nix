{ config, pkgs, ... }: {
  # Users
  users.users.overlord = {
    isNormalUser = true;
    description = "overlord";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      fastfetch
      
      firefox
      librewolf
      thunderbird
      gimp
      inkscape
      steam
      
      blender
      godot_4
      bottles
      gnome.ghex
    ];
    shell = pkgs.fish;
  };
}
