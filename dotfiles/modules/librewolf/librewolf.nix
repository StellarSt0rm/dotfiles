# Example - https://gitlab.com/usmcamp0811/dotfiles/-/blob/fb584a888680ff909319efdcbf33d863d0c00eaa/modules/home/apps/firefox/default.nix
# Help - https://github.com/nix-community/home-manager/issues/6154
# Doc - https://librewolf.net/docs/settings

{ inputs, pkgs, ... }: {
  # Remove when this PR is backported: https://github.com/nix-community/home-manager/pull/5684
  nixpkgs.overlays = [
    (final: prev: {
      home-manager = prev.home-manager // {
        programs.librewolf = import "${inputs.home-librewolf.outPath}/modules/programs/librewolf.nix";
      };
    })
  ];

  home.file."gnome-theme" = {
    target = ".librewolf/gemini/chrome/gnome-theme";
    source = fetchTarball {
      url = "https://github.com/rafaelmardojai/firefox-gnome-theme/archive/refs/tags/v134.tar.gz";
      sha256 = "sha256:072kaq9x7gjzwxzql3yn4x523is65pgzczaaw9a2rdc4gnm4ggsb";
    };
  };

  programs.librewolf = {
    enable = true;

    policies = {
      PasswordManagerEnabled = false;

      # Telemetry
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      EnableTrackingProtection = true;

      # Looks
      DisplayBookmarksToolbar = "never";
      OverrideFirstRunPage = "";
      OverridePostUpdatePage = "";
    };

    profiles.gemini = {
      id = 0;
      name = "Gemini";
      isDefault = true;

      search = {
        force = true;

        default = "Startpage";
        privateDefault = "Startpage";
        order = [ "Startpage" ];

        engines = {
          "Startpage" = {
            urls = [{
              template = "https://www.startpage.com/do/search";

              params = [
                { name = "query"; value = "{searchTerms}"; }
                { name = "prfe"; value = (builtins.readFile ./startpage.conf); }
              ];
            }];

            iconUpdateURL = "http://startpage.com/sp/cdn/favicons/favicon-gradient.ico";
          };

          "Bing".metaData.hidden = true;
          "DuckDuckGo".metaData.hidden = true;
          "Google".metaData.hidden = true;
          "Wikipedia (en)".metaData.hidden = true;
          "History".metaData.hidden = true;
        };
      };

      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        ublock-origin
        bitwarden

        sponsorblock
        youtube-recommended-videos # Unhook extension

        unpaywall
        tabliss
      ];

      settings = {
        "privacy.clearOnShutdown_v2.cookiesAndStorage" = false;
        "security.donottrackheader.enabled" = true;
        "privacy.resistFingerprinting" = false; # Breaks a lot of websites
        "browser.startup.page" = 3; # Keep open windows
        "general.autoScroll" = true;

        "browser.download.autohideButton" = true;
        "browser.download.alwaysOpenPanel" = true;

        # Annoyances
        "media.videocontrols.picture-in-picture.video-toggle.enabled" = false;
        "clipboard.autocopy" = false;
        "middlemouse.paste" = false;
        "webgl.disabled" = false;

        "extensions.pocket.showHome" = false;
        "extensions.pocket.enabled" = false;
        "signon.rememberSignons" = false;
        "browser.uitour.enabled" = false;

        "identity.fxaccounts.enabled" = false;
        "identity.fxaccounts.toolbar.enabled" = false;
        "identity.fxaccounts.pairing.enabled" = false;
        "identity.fxaccounts.commands.enabled" = false;

        "dom.battery.enabled" = false;
        "dom.private-attribution.submission.enabled" = false;

        # Looks
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "widget.gtk.rounded-bottom-corners.enabled" = true;
        "svg.context-properties.content.enabled" = true;
        "browser.theme.dark-private-windows" = false;
        "browser.uidensity" = 0;

        "gnomeTheme.systemIcons" = true;
        "gnomeTheme.hideWebrtcIndicator" = true;
        "gnomeTheme.hideSingleTab" = true;

        "browser.uiCustomization.state" = builtins.toJSON {
          placements = {
            widget-overflow-fixed-list = [ ];

            nav-bar = [
              "back-button"
              "forward-button"
              "stop-reload-button"
              "new-tab-button"
              "customizableui-special-spring1"
              "urlbar-container"
              "customizableui-special-spring2"
              "save-to-pocket-button"
              "downloads-button"
              "fxa-toolbar-menu-button"
              "_446900e4-71c2-419f-a6a7-df9c091e268b_-browser-action"
              "unified-extensions-button"
            ];
            toolbar-menubar = [ "menubar-items" ];

            TabsToolBar = [ "tabbrowser-tabs" ];
            PersonalToolbar = [ "import-button" "personal-bookmarks" ];
          };

          seen = [
            "developer-button"
            "ublock0_raymondhill_net-browser-action"
            "_446900e4-71c2-419f-a6a7-df9c091e268b_-browser-action"
            "_f209234a-76f0-4735-9920-eb62507a54cd_-browser-action"
            "myallychou_gmail_com-browser-action"
            "sponsorblocker_ajay_app-browser-action"
          ];

          dirtyAreaCache = [ ];
          currentVersion = 20;
          newElementCount = 0;
        };
      };

      userChrome = ''
        @import "gnome-theme/userChrome.css";

        /* Custom styles */
        ${builtins.readFile ./styles/customChrome.css}
      '';
      userContent = ''
        @import "gnome-theme/userContent.css";

        /* Custom Content Styles */
        ${builtins.readFile ./styles/customContent.css}
      '';
    };
  };
}
