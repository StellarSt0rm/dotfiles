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
      ./home.nix
      ./user.nix
      
      ./packages.nix
      ./programs/programs.nix
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
