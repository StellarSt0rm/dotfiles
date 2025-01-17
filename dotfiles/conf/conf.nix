{ config, ... }: {
  systemd.user.tmpfiles.rules = [
    "L+ %h/.config/fastfetch/config.jsonc 0755 - - - ${toString ./fastfetch.jsonc}"
    "L+ %h/.config/fish/config.fish       0755 - - - ${toString ./fish.fish}"
    "L+ %h/.config/fish/oh-my-posh.toml   0755 - - - ${toString ./oh-my-posh.toml}"
  ];
}
