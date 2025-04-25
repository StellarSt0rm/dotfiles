{ pkgs, lib, gpg-keys, ... }: {
  # Enable dconf
  programs.dconf.enable = true;

  # Enable and configure git
  programs.git = {
    enable = true;

    config = {
      user = {
        email = "StellarSt0rm@proton.me";
        name = "StellarSt0rm";

        signingKey = gpg-keys.master-id;
      };
      commit.gpgSign = true;

      pull.rebase = true;
      push.rebase = false;
      push.autoSetupRemote = true;

      "url \"git@github.com:\"".insteadOf = "https://github.com/";
    };
  };

  # Enable and configure Kanata
  services.kanata = {
    enable = lib.mkDefault true;

    keyboards.default.config = ''
      ;; Map RCtrl to Menu key
      (defsrc
        rctrl
      )

      (deflayer base
        menu
      )
    '';
  };

  # Enable sudo inults
  security.sudo.package = pkgs.sudo.override { withInsults = true; };
  security.sudo.extraConfig = "Defaults insults";

  # Export config files
  home-manager.users.gemini.home.file = {
    ".config/fastfetch/config.jsonc".source = ./fastfetch.jsonc;
    ".config/fish/config.fish".source = ./fish.fish;
    ".config/fish/oh-my-posh.toml".source = ./oh-my-posh.toml;
  };

  environment.etc."sshcontrol" = {
    text = gpg-keys.auth-keygrip;
    user = "gemini";
    mode = "0600";
  };

  # Parabolic crashes if it cant write to it's config file ⌤
  systemd.tmpfiles.rules = [
    "C+ %h/.config/Nickvision\ Tube\ Converter/config.json - - - - ${./parabolic.json}"
    "L+ %h/.gnupg/sshcontrol 0600 - - - /etc/sshcontrol"
  ];
}
