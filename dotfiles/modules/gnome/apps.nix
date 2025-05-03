{ lib, ... }: {
  dconf.settings = with lib.hm.gvariant; {
    "org/gnome/nautilus/preferences".show-create-link = true;

    "org/gnome/Console" = {
      last-window-size = (mkTuple [ 790 500 ]);
      last-window-maximised = false;

      ignore-scrollback-limit = true;
      audible-bell = false;
      visual-bell = false;
    };

    "org/gnome/TextEditor" = {
      restore-session = false;
      indent-style = "space";
      tab-width = 2;

      highlight-current-line = true;
      show-line-numbers = true;
      show-map = true;
      wrap-text = false;
    };

    "com/github/neithern/g4music" = {
      # Gapless
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
      trash-dir = "/home/gemini/Documents/Notes";
      enable-autosave = true;

      cheatsheet-enabled = true;
      toolbar-enabled = true;
      note-max-width = -1;
    };

    "io/github/seadve/Kooha" = {
      framerate = (mkTuple [ 30 1 ]);
      profile-id = "matroska-h264"; # Smaller sizes than mp4
    };
  };
}
