{ config, pkgs, ... }: {
  programs.dconf.enable = true;
  
  home.username = "gemini";
  home.homeDirectory = "/home/gemini";
  
  # Kanata configuration
  hardware.uinput.enable = true; # Needed for Kanata to work!
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
  
  # Set set time zone to Europe/Madrid
  time.timeZone = "Europe/Madrid";
  
  # Set language to en_US
  i18n.defaultLocale = "en_US.UTF-8";
  
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };
  
  # Configure keyboard layout and variant
  services.xserver.xkb = {
    layout = "es";
    variant = "cat";
  };
  
  console.keyMap = "es";
  
  # Enable Wayland windowing system.
  services.xserver = {
    enable = true;
    displayManager.gdm = {
      enable = true;
      wayland = true;
    };
    desktopManager.gnome.enable = true;
  };
  
  services.displayManager.defaultSession = "gnome"; # Default to GNOME Wayland
  
  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  
  # Fix GStreamer Plug-in Issue
  environment.sessionVariables.GST_PLUGIN_SYSTEM_PATH_1_0 = lib.makeSearchPathOutput "lib" "lib/gstreamer-1.0" (with pkgs.gst_all_1; [
    gst-plugins-good
    gst-plugins-bad
    gst-plugins-ugly
    gst-libav
  ]);
}
