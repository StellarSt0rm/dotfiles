{ inputs, pkgs, ... }: {
  # Remove when this PR is backported: https://github.com/nix-community/home-manager/pull/5684  
  nixpkgs.overlays = [(final: prev: {
    home-manager = prev.home-manager // {
      programs.librewolf = import "${inputs.home-librewolf.outPath}/modules/programs/librewolf.nix";
    };
  })];
  
  home.file."material-fox" = {
    target = ".librewolf/gemini/chrome/material-fox";
    source = pkgs.fetchzip {
      url = "https://github.com/edelvarden/material-fox-updated/releases/download/v1.3.0/chrome.zip";
      hash = "sha256-axAKxcCnAw8ARmNHviuP/S8yAqj2KMCAfiz7r28Ymkw=";
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
            urls = [{ template = "https://startpage.com/do/search?query={searchTerms}&prfe=${builtins.readFile ./startpage.conf}"; }];
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
        "browser.startup.page" = 3; # Keep open windows
        
        # Annoyances
        "clipboard.autocopy" = false;
        "middlemouse.paste" = false;
        
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
        "layout.css.color-mix.enabled" = true;
        
        "userChrome.ui-context-menu-icons" = true;
        "userChrome.theme-material" = false;
        
        "browser.uiCustomization.state" = builtins.toJSON {
          placements = {
            widget-overflow-fixed-list = [];
            
            nav-bar = [
              "back-button"
              "forward-button"
              "stop-reload-button"
              "customizableui-special-spring1"
              "urlbar-container"
              "customizableui-special-spring2"
              "save-to-pocket-button"
              "downloads-button"
              "ublock0_raymondhill_net-browser-action"
              "fxa-toolbar-menu-button"
              "unified-extensions-button"
            ];
            toolbar-menubar = [ "menubar-items" ];
            
            TabsToolBar = [
              "tabbrowser-tabs"
              "new-tab-button"
            ];
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
          
          dirtyAreaCache = [];
          currentVersion = 20;
          newElementCount = 0;
        };
      };
      
      userChrome = ''
        @import "material-fox/userChrome.css";
        
        /* Custom styles */
        ${builtins.readFile ./styles/customChrome.css}
      '';
      userContent = ''
        @import "material-fox/userContent.css";
        
        /* Custom Content Styles */
        ${builtins.readFile ./styles/customContent.css}
      '';
    };
  };
}
