{ lib, ... }:
let
  burn-my-windows-profile = pkgs.writeText "nix-profile.conf" ''
    [burn-my-windows-profile]
    fire-enable-effect=false
    glide-enable-effect=true
    glide-squish=0.15
    glide-shift=-0.25
    glide-scale=0.85
    glide-tilt=0.25
  '';
in {
  environment.systemPackages = with pkgs.gnomeExtensions; [
    quick-settings-tweaker
    clipboard-indicator
    tiling-assistant
    just-perfection
    burn-my-windows
    blur-my-shell
    appindicator
    dash-to-dock
    mpris-label
    alttab-mod
    pip-on-top
    caffeine
  ];
  
  dconf.settings = with lib.hm.gvariant; {
    "org/gnome/shell".enabled-extiensions = [
      "just-perfection-desktop@just-perfection"
      "appindicatorsupport@rgcjonas.gmail.com"
      "burn-my-windows@schneegans.github.com"
      "tiling-assistant@leleat-on-github"
      "clipboard-indicator@tudmotu.com"
      "mprisLabel@moon-0xff.github.com"
      "pip-on-top@rafostar.github.com"
      "dash-to-dock@micxgx.gmail.com"
      "quick-settings-tweaks@qwreey"
      "alttab-mod@leleat-on-github"
      "caffeine@patapon.info"
      "app-hider@lynith.dev"
      "blur-my-shell@aunetx"
      "emoji-copy@felipeftn"
    ];
    
    # Config
  };
}
