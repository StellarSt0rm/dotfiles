{ lib, ... }: {
  dconf.settings = with lib.hm.gvariant; {
    "org/gnome/nautilus/preferences".show-create-link = true;
    
    "org/gnome/Console" = {
      last-window-size = (mkTuple [790 500]);
      last-window-maximised = false;
      
      use-system-font = false;
      custom-font = "Maple Mono 10";
      ignore-scrollback-limit = true;
      
      audible-bell = false;
      visual-bell = false;
    };
    
    "org/gnome/TextEditor" = {
      restore-session = true;
      indent-style = "space";
      tab-width = 2;
      
      highlight-current-line = true;
      show-line-numbers = true;
      show-map = true;
      wrap-text = false;
      
      use-system-font = false;
      custom-font = "Maple Mono 11";
    };
    
    "com/github/neithern/g4music" = { # Gapless
      audio-sink = "pulsesink";
      gapless-playback = true;
      play-background = true;
      replay-gain = (mkUint32 1); # Track
      
      single-click-activate = true;
      blur-mode = (mkUint32 0); # None
      rotate-cover = false;
      grid-mode = true;
      show-peak = true;
      
      monitor-changes = true;
    };
    
    "com/toolstack/Folio" = {
      notes-dir = "/home/gemini/Documents/Notes";
      trash-dir = "/home/gemini/Documents/Notes/Trash";
      enable-autosave = true;
      
      cheatsheet-enabled = true;
      toolbar-enabled = true;
      note-max-width = -1;
    };
  };
}
