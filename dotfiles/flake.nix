{
  description = "Overthrow the government! /j";
  
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    # Other Flakes
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
  };
  
  outputs = { self, nixpkgs, home-manager }@inputs:
  let
    global_modules = [
      # Fix error when a command isnt found + Pass inputs to all modules
      ({ config = { nix.registry.nixpkgs.flake = nixpkgs; }; })
      { _module.args = { inherit inputs; }; }
      
      # Main modules
      ./user.nix
      ./packages.nix

      ./configs/configs.nix
      
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
    };
  };
}
