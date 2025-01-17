# https://github.com/RoastBeefer00/nix-home/blob/main/nix_modules/waybar.nix
# https://github.com/Alexays/Waybar/wiki/Configuration

{ ... }: {
  programs.waybar = {
    settings = [{
      layer = "top";
      position = "top";
      
      exclusive = true;
      passthrough = false;
      gtk-layer-shell = true;
    }];
  };
}
