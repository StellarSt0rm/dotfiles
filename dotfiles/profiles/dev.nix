{ pkgs, lib, ... }: {
  environment.systemPackages = with pkgs; [
    # Coding
    rust-analyzer
    zed-editor
    #docker
    rustup
    gcc
  ];

  # Docker
  users.users.gemini.extraGroups = [ "docker" ];
}
