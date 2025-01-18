{ stdenv, pkgs }: {
  nvchad = stdenv.mkDerivation rec {
    name = "nvchad";

    src = pkgs.fetchFromGitHub {
      owner = "NvChad";
      repo = "NvChad";
      rev = "c8777040fbda6a656f149877b796d120085cd918";
      sha256 = "sha256-J4SGwo/XkKFXvq+Va1EEBm8YOQwIPPGWH3JqCGpFnxY=";
    };

    installPhase = ''
      # Fetch whole repo and put in in $out
      mkdir -p $out
      cp -r ./* $out/
      cd $out/
      cp -r ${./custom} $out/lua/custom
    '';
  };
}
