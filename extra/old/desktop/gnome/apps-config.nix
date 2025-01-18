{ pkgs, lib, ... }: {
  dconf.settings = with lib.hm.gvariant; {
    "org/gnome/nautilus/preferences".show-create-link = true;
    
    "org/gnome/Console" = {
      last-window-size = (mkTuple [790 500]);
      last-window-maximised = false;
      audible-bell = false;
      visual-bell = false;
    };
    
    "org/gnome/TextEditor" = {
      restore-session = false;
      
      show-line-numbers = true;
      highlight-current-line = true;
      show-map = true;
      
      wrap-text = false;
      tab-width = 2;
      
      custom-font = "Maple Mono 11";
      use-system-font = false;
    };
    
    "com/github/neithern/g4music" = {
      blur-mode = (mkUint32 0);
      sort-mode = (mkUint32 3);
      
      rotate-cover = false;
      show-peak = true;
      remain-progress = true; # Show remaining time instead of total
      
      gapeless-playback = true;
      monitor-changes = true;
      play-background = true; # Keep playing when window closed
    };
  };
}
