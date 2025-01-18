{
  description = "Overthrow the government! /j";
  
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  
  outputs = { self, nixpkgs, home-manager }:
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
  in {
    nixosConfigurations = {
      mercury = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = global_modules ++ [ ./hosts/mercury/mercury.nix ];
      };
      
      # Test host, each vm needs it's own `test-hardware.nix`,
      # that's why it's ignored in .gitignore
      test = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = global_modules ++ [ ./hosts/test/test.nix ];
      };
    };
  };
}
