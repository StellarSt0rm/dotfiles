{ config, ... }: 
let
  XDG_DATA = "/home/gemini/.local/share";
  XDG_CONFIG = "/home/gemini/.config";
  XDG_STATE = "/home/gemini/.local/state";
  XDG_CACHE = "/home/gemini/.cache";
in {
  environment.variables = {
    XDG_DATA_HOME = XDG_DATA;
    XDG_CONFIG_HOME = XDG_CONFIG;
    XDG_STATE_HOME = XDG_STATE;
    XDG_CACHE_HOME = XDG_CACHE;

    # XDG_DATA
    ANDROID_USER_HOME = "${XDG_DATA}/android";
    CARGO_HOME = "${XDG_DATA}/cargo";
    RUSTUP_HOME = "${XDG_DATA}/rustup";
    WINEPREFIX = "${XDG_DATA}/wine";
    GNUPGHOME = "${XDG_DATA}/gnupg";

    # XDG CONFIG
    DOCKER_CONFIG = "${XDG_CONFIG}/docker";

    # XDG STATE
    HISTFILE = "$XDG_STATE/bash/history";

    # XDG CACHE
    CUDA_CACHE_PATH = "$XDG_CACHE/cuda";
  };

  nix.settings.use-xdg-base-directories = true;
}
