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

  # Configure the GPG agent
  home-manager.users.gemini.services.gpg-agent = {
    enable = true;
    sshKeys = [ gpg-keys.auth-keygrip ];
  };

  programs.gnupg.agent.settings = {
      default-cache-ttl = 5 * 60;
      max-cache-ttl = 15 * 60;

      default-cache-ttl-ssh = 5 * 60;
      max-cache-ttl-ssh = 15 * 60;
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
    ".gitignore".source = ./home_gitignore.txt;

    ".config/fish/config.fish".source = ./fish/fish.fish;
    ".config/fish/fish_variables".source = ./fish/fish_variables.fish;
    ".config/fish/oh-my-posh.toml".source = ./fish/oh-my-posh.toml;

    ".config/fastfetch/config.jsonc".source = ./fastfetch.jsonc;
    ".config/zed/settings.json".source = ./zed.jsonc;
  };

  # Parabolic crashes if it cant write to it's config file ⌤
  systemd.tmpfiles.rules = [
    "C+ \"/home/gemini/.config/Nickvision Tube Converter/config.json\" 644 gemini - - ${./parabolic.json}"
  ];
}
