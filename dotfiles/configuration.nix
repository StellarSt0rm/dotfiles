# This is a minimal bootstrapping configuration,
# it's only purpose is to facilitate bootstrapping.
#
# If one day flakes becomes stable,
# this will probably be deleted,
# but until then, this lives on...

{ config, ... }: {
  # Enable flakes
  nix.settings.experimental-features = [ "flakes" ];
}
