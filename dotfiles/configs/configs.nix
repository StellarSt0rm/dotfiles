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
  systemd.user.tmpfiles.rules = [
    "L+ %h/.config/fastfetch/config.jsonc 0755 - - - ${toString ./fastfetch.jsonc}"
    "L+ %h/.config/fish/config.fish       0755 - - - ${toString ./fish.fish}"
    "L+ %h/.config/fish/oh-my-posh.toml   0755 - - - ${toString ./oh-my-posh.toml}"
    
    "L+ %h/.config/Nickvision\\x20Tube\\x20Converter/config.json 0755 - - - ${toString ./parabolic.json}"
  ];
}
