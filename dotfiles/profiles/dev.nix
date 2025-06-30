{ pkgs, lib, ... }: {
  environment.systemPackages = with pkgs; [
    # Coding
    rust-analyzer
    zed-editor
    rustup
    gcc
  ];

  # Docker
  #virtualisation.docker.enable = lib.mkDefault true;
  users.users.gemini.extraGroups = [ "docker" ];
}
