{
  description = "Overthrow the government! /j";
  
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-24.11";
    
    home-manager = {
      url = "github:nix-comunity/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    niri.url = "github:sodiboo/niri-flake";
  };
  
  outputs = { self, lib, nixpkgs, home-manager, niri }:
  let
    global_modules = [
      ./user.nix
      ./packages.nix
      ./modules/niri.nix
      
      # Import program configs
      ./conf/conf.nix
      
      # Home Manager
      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        
        # Use mkMerge to unify multiple files
        home-manager.users.gemini = lib.mkMerge [
          (import ./modules/home.nix)
          (import ./modules/waybar.nix)
        ];
      }
    ];
  in {
    nixosConfigurations = {
      mercury = nixpkg.lib.nixosSystem {
        system = "x86_64-linux";
        modules = global_modules ++ [ ./hosts/mercury/mercury.nix ];
      };
    };
  };
}
