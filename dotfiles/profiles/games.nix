{ pkgs, ... }: {
  # Setup steam
  programs.steam = {
    enable = true;
    protontricks.enable = true;
    localNetworkGameTransfers.openFirewall = true;

    package = pkgs.steam.override {
      extraPkgs = pkgs: with pkgs; [
        bibata-cursors
      ];
    };
  };

  # Extra packages
  environment.systemPackages = with pkgs; [
    (pkgs.bottles.override { removeWarningPopup = true; })
    prismlauncher
  ];
}
