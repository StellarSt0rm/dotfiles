{
  description = "Overthrow The Government!";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Other Flakes
    nix-index-db = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs = { nixpkgs, home-manager, nur, nix-index-db, nixos-hardware, ... }@inputs:
    let
      core_profile = [
        # Fix error when a command isnt found + Pass inputs to all modules
        nix-index-db.nixosModules.nix-index
        { _module.args = { inherit inputs; }; }

        # Overlays
        nur.modules.nixos.default

        # Home Manager
        home-manager.nixosModules.home-manager {
          home-manager.backupFileExtension = "hm-backup";
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
        }

        # Modules
        ./user.nix
        ./profiles/core.nix

        ./modules/modules.nix
        ./configs/configs.nix
      ];

      dev_profile = [
        ./profiles/dev.nix
      ];

      games_profile = [
        ./profiles/games.nix
      ];
    in {
      nixosConfigurations = {
        starlight = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules =
            core_profile ++
            dev_profile ++
            games_profile ++
            [ ./hosts/starlight/starlight.nix ];

          specialArgs = {
            host-system = {
              hostname = "starlight";
              initial-version = "24.11";
            };

            gpg-keys = {
              master-id = "4867A41786FC667B6F000FEFBAFDF67DF7BC314C";
              auth-keygrip = "468D0E31DF3ADAFA91C0A84303A33F7BA62F7705";
            };
          };
        };

        mercury = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules =
            core_profile ++
            dev_profile ++
            [ nixos-hardware.nixosModules.framework-13-7040-amd ./hosts/mercury/mercury.nix ];

          specialArgs = {
            host-system = {
              hostname = "mercury";
              initial-version = "25.05";
            };

            gpg-keys = {
              master-id = "1CE33E3D4F59F031BE0150C5B1CC8B296979DAF1";
              auth-keygrip = "B434F89128E9B85ECFD29C94FD7064196E5CDE63";
            };
          };
        };
      };
    };
}
