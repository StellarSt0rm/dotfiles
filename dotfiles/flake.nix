{
  description = "Overthrow The Government!";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Other Flakes
    home-librewolf = {
      url = "github:nix-community/home-manager/pull/5684/head";
      flake = false;
    };
  };

  outputs = { nixpkgs, home-manager, nur, ... }@inputs:
    let
      global_modules = [
        # Fix error when a command isnt found + Pass inputs to all modules
        {
          config = { nix.registry.nixpkgs.flake = nixpkgs; };
          _module.args = { inherit inputs; };
        }

        # Overlays
        nur.modules.nixos.default

        # Home Manager
        home-manager.nixosModules.home-manager
        {
          home-manager.backupFileExtension = "hm-backup";
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
        }

        # Main modules
        ./user.nix
        ./packages.nix

        ./modules/modules.nix
        ./configs/configs.nix
      ];
    in
    {
      nixosConfigurations = {
        mercury = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = global_modules ++ [ ./hosts/mercury/mercury.nix ];
        };
      };
    };
}
