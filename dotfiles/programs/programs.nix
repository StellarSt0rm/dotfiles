{ config, ... }:
let
  path = toString ./;
in {
  # Copy program configs
  systemd.user.tmpfiles.rules = [
    "L+ %h/.config/fastfetch/config.jsonc 0755 - - - ${path}/fastfetch.jsonc"
    "L+ %h/.config/fish/config.fish 0777 - - - ${path}/fish.fish"
  ];
}
