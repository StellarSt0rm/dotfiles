{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    # Coding
    rust-analyzer
    zed-editor
    rustup
    gcc
  ];
}
