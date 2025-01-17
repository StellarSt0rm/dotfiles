{
  description = "Overthrow the government! /j";
  
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    niri.url = "github:sodiboo/niri-flake";
  };
  
  outputs = { self, nixpkgs, home-manager, niri }:
  let
    global_modules = [
      ./user.nix
      ./packages.nix

      # Import program configs
      ./conf/conf.nix
      
      # Home Manager
      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        
        home-manager.users.gemini = import ./modules/home.nix;
      }
    ];

    # Overlays
    system = "x86_64-linux";

    pkgs = import nixpkgs {
      inherit system;

      overlays = [
        niri.overlays.niri
      ];
    };
  in {
    nixosConfigurations = {
      mercury = nixpkgs.lib.nixosSystem {
        inherit pkgs;

        modules = global_modules ++ [ ./hosts/mercury/mercury.nix ];
      };
    };
  };
}
