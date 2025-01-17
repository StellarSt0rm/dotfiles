{ config, ... }:
let
  path = toString ./;
in {
  systemd.user.tmpfiles.rules = [
    "L+ %h/.config/fastfetch/config.jsonc 0755 - - - ${path}/fastfetch.jsonc"
    "L+ %h/.config/fish/config.fish       0755 - - - ${path}/fish.fish"
    "L+ %h/.config/fish/oh-my-posh.toml   0755 - - - ${path}/oh-my-posh.toml"
  ];
}
