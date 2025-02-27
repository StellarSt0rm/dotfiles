{ pkgs, ... }: {
  # Enable dconf
  programs.dconf.enable = true;

  # Enable and configure git
  programs.git = {
    enable = true;

    config = {
      "credential \"https://github.com\"" = {
        helper = "!/run/current-system/sw/bin/gh auth git-credential";
      };
      "credential \"https://gist.github.com\"" = {
        helper = "!/run/current-system/sw/bin/gh auth git-credential";
      };

      user = {
        email = "StellarSt0rm@proton.me";
        name = "StellarSt0rm";
      };
      commit.gpgSign = true;

      pull.rebase = true;
      push.rebase = false;

      "url \"git@github.com:\"".insteadOf = "https://github.com/";
    };
  };

  # Enable and configure Kanata
  services.kanata = {
    enable = true;

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
  
  # Parabolic crashes if it cant write to it's config file ⌤
  systemd.tmpfiles.rules = [
    "C+ %h/.config/Nickvision Tube Converter/config.json - - - - ${./parabolic.json}"
  ];
}
