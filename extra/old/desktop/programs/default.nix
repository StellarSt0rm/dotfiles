{ pkgs, ... }:
let
  path = "/etc/nixos/desktop/programs";
in {
  imports = [
    ./firefox
  ];

  # Copy program configs
  systemd.user.tmpfiles.rules = [
    "L+ %h/.config/fastfetch 0755 - - - ${path}/fastfetch"
    "L+ %h/.config/fish 0777 - - - ${path}/fish"
  ];
}
