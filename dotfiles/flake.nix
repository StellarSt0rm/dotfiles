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
  
  outputs = { self, nixpkgs, home-manager, niri, waybar }:
  let
    global_modules = [
      ./user.nix
      ./niri.nix
      
      ./packages.nix
      ./programs/programs.nix
      
      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        
        home-manager.users.gemini = import ./home.nix;
      }
    ];
  in {
    nixosConfigurations = {
      mercury = nixpkg.lib.nixosSystem {
        system = "x86_64-linux";
        modules = global_modules ++ [ ./hosts/mercury.nix ];
      };
    };
  };
}
