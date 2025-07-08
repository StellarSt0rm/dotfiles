{ pkgs, lib, gpg-keys, ... }: {
  imports = [
    ./dotfiles.nix
  ];

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
    enableSshSupport = true;
    sshKeys = [ gpg-keys.auth-keygrip ];
  };

  programs.gnupg.agent.settings = {
      default-cache-ttl = 5 * 60;
      max-cache-ttl = 15 * 60;

      default-cache-ttl-ssh = 15 * 60;
      max-cache-ttl-ssh = 30 * 60;
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
    ".config/fish/config.fish".source = ./fish/fish.fish;
    ".config/fish/fish_variables".source = ./fish/fish_variables.fish;
    ".config/fish/oh-my-posh.toml".source = ./fish/oh-my-posh.toml;
    ".config/fish/fd_gitignore".source = ./fish/fd_gitignore.txt;

    ".config/fastfetch/config.jsonc".source = ./fastfetch.jsonc;
    ".config/zed/settings.json".source = ./zed.jsonc;
    
    ".config/Nickvision Parabolic/config.json".source = ./parabolic.json;
  };
}
