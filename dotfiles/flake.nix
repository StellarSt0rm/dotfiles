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
              master-id = "A7A6D89157D6249054583DC10046FFCB3C711ECA";
              auth-keygrip = "EA15C8B157B1C130A23B180AEB3B383D19A17B5C";
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
              master-id = "E12558B683C64DF0D192A8C86F3224320D1376EF";
              auth-keygrip = "40BBEE706E621A996BB9C14C7D584F74567902A8";
            };
          };
        };
      };
    };
}
