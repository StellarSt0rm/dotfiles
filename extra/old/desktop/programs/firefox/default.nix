{ lib, ...}:
let
  path = "/etc/nixos/desktop/programs/firefox";
  
  # To install new extensions: Install it normally, then
  # go to "about:debugging#/runtime/this-firefox" and get the UUID of the extension
  # then go to the Extension's page and derive the ID from the URL
  # format: ("uuid" "id")
  extensions = {
    "{446900e4-71c2-419f-a6a7-df9c091e268b}" = "bitwarden-password-manager";
    #"jid1-MnnxcxisBPnSXQ@jetpack" = "privacy-badger17";
     
    # Websites
    "addon@darkreader.org" = "darkreader";
    "uBlock0@raymondhill.net" = "ublock-origin";
    
    "sponsorBlocker@ajay.app" = "sponsorblock";
    "deArrow@ajay.app" = "dearrow"; # UserID: eQOgScFArUY1FX9rRLjB252oMflgAUR7BJA7
    "{21f1ba12-47e1-4a9b-ad4e-3a0260bbeb26}" = "remove-youtube-s-suggestions";
    "{762f9885-5a13-4abd-9c77-433dcd38b8fd}" = "return-youtube-dislikes";
    
    "DontFuckWithPaste@raim.ist" = "don-t-fuck-with-paste";
    #"idcac-pub@guus.ninja" = "istilldontcareaboutcookies";
    #"skipredirect@sblask" = "skip-redirect";
  };
in {
  home.file."firefox-theme" =  {
    target = ".mozilla/firefox/default/chrome/firefox-theme";
    #source = (fetchTarball "https://github.com/QNetITQ/WaveFox/archive/master.tar.gz");
    source = (fetchTarball "https://github.com/rafaelmardojai/firefox-gnome-theme/archive/master.tar.gz");
  };
  
  programs.firefox = {
    enable = true;
    
    profiles.default = {
      name = "Default";
      
      settings = {
        "webgl.disabled" = false;
        "widget.gtk.rounded-bottom-corners.enabled" = true;
        
        # PIP Options
        "media.videocontrols.picture-in-picture.display-text-tracks.size" = "small";
        "media.videocontrols.picture-in-picture.respect-disablePictureInPicture" = false;
        "media.videocontrols.picture-in-picture.video-toggle.min-video-secs" = 0;
        "media.videocontrols.picture-in-picture.video-toggle.enabled" = false;
        
        # NewTab
        "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
        "browser.newtabpage.activity-stream.feeds.snippets" = false;
        "browser.newtabpage.activity-stream.section.highlights.includePocket" = false;
        "browser.newtabpage.activity-stream.section.highlights.includeBookmarks" = false;
        "browser.newtabpage.activity-stream.section.highlights.includeDownloads" = false;
        "browser.newtabpage.activity-stream.section.highlights.includeVisited" = false;
        "browser.newtabpage.activity-stream.showSponsored" = false;
        "browser.newtabpage.activity-stream.system.showSponsored" = false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        
        # Trackers
        "privacy.donottrackheader.enabled" = true;
        "privacy.globalprivacycontrol.enabled" = true;
        "privacy.trackingprotection.emailtracking.enabled" = true;
        "privacy.trackingprotection.enabled" = true;
        "privacy.trackingprotection.socialtracking.enabled" = true;
        
        # UI Customization
        "browser.uiCustomization.state" = "${builtins.toJSON {
          placements = {
            widget-overflow-fixed-list = [];
            nav-bar = [
              "back-button"
              "forward-button"
              "stop-reload-button"
              "urlbar-container"
              "downloads-button"
              "bookmarks-menu-button"
              "_446900e4-71c2-419f-a6a7-df9c091e268b_-browser-action"
              "unified-extensions-button"
            ];
            toolbar-menubar = [ "menubar-items" ];
            TabsToolBar = [
              "tabbrowser-tabs"
              "new-tab-button"
              "alltabs-button"
            ];
            PersonalToolbar = [ "import-button" "personal-bookmarks" ];
          };
          seen = [ "developer-button" "save-to-pocket-button" "firefox-view-button" ] ++ builtins.map (extension:
            lib.toLower (
              builtins.replaceStrings ["." "@"] ["_" "_"] extension
            ) + "-browser-action"
          ) (builtins.attrNames extensions);
          
          dirtyAreaCache = [];
          currentVersion = 20;
          newElementCount = 0;
        }}";
        
        # Custom CSS
        #"toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        #"userChrome.Style.ThirdParty.Enabled" = true;
        #"userChrome.Menu.Size.Compact.Enabled" = true;
        
        #"userChrome.DragSpace.Left.Disabled" = true;
        #"userChrome.DragSpace.Top.Windowed.Enabled" = true;
        #"userChrome.Menu.Icons.Regular.Enabled" = true;
        #"userChrome.Tabs.Option4.Enabled" = true;
        
        #"userChrome.NavBar.Floating.Enabled" = true;
        
        "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "browser.tabs.drawInTitlebar" = true;
        "svg.context-properties.content.enabled" = true;
      };
      
      userChrome = ''
        @import "firefox-theme/userChrome.css";
        @import "firefox-theme/theme/colors/dark.css"; 
        
        /* Custom Chrome Styles */
        ${builtins.readFile "${path}/chrome/customChrome.css"}
      '';
      
      userContent = ''
        @import "theme/colors/dark.css";
        
        @import "theme/pages/newtab.css";
        @import "theme/pages/privatebrowsing.css";

        @import "theme/parts/video-player.css";
        
        /* Custom Content Styles */
        ${builtins.readFile "${path}/chrome/customContent.css"}
      '';
    };
    
    policies = {
      # Telemetry
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      EnableTrackingProtection = true;
      OverrideFirstRunPage = "";
      OverridePostUpdatePage = "";
      DontCheckDefaultBrowser = true;
      DisplayBookmarksToolbar = "never";
      
      # Extensions
      ExtensionSettings = lib.mapAttrs
        (_: name: {
          installation_mode = "normal_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/${name}/latest.xpi";
        })
        extensions;
        
      "3rdparty".Extensions = {
        # Allow Certain Extensions To Run In Private Mode
        "uBlock0@raymondhill.net".permissions =  [ "internal:privateBrowsingAllowed" ];
      
        # https://github.com/gorhill/uBlock/blob/master/platform/common/managed_storage.json
        "uBlock0@raymondhill.net".adminSettings = {
          userSettings = rec {
            uiTheme = "dark";
          };
          selectedFilterLists = [
            "user-filters"
            "ublock-filters"
            "ublock-badware"
            "ublock-privacy"
            "ublock-quick-fixes"
            "ublock-unbreak"
            "easylist"
            "easyprivacy"
            "urlhaus-1"
            "plowe-0"
            "fanboy-cookiemonster"
            "ublock-cookies-easylist"
            "easylist-annoyances"
          ];
          userFilters = ''
            !! Reddit.com
            ! Annoyances
            reddit.com##award-button
            reddit.com##[data-part="advertise"]
            reddit.com##[data-part="create"]
            
            reddit.com##faceplate-tracker[noun="contributor_program"]
            reddit.com##faceplate-tracker[noun="advertise"]:upward(1)
            reddit.com##faceplate-tracker[noun="premium_menu"]:upward(1)
            
            ! Aesthetic
            reddit.com###user-drawer-content hr:nth-last-child(-n+4)
            reddit.com##shreddit-darkmode-setter
            
            !! Discord.com
            ! Annoyances
            discord.com##button[aria-label="Send a gift"]
            discord.com##button[aria-label="Open GIF picker"]
            discord.com##button[aria-label="Open sticker picker"]
            discord.com##button[aria-label="Apps"]
            				
            discord.com##div[aria-label="Download Apps"]
            discord.com##li > div > a[href="/shop"]
            discord.com##li > div > a[href="/store"]
          '';
        };
      };
    };
  };
}
