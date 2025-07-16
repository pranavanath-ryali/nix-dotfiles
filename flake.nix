{
    description = "NixOS Dotfiles";

    inputs = {
        # Nixpkgs
        nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

        # Home Manager (Standalone Installation)
        home-manager.url = "github:nix-community/home-manager/master";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";
    };

    outputs = inputs@{ self, ... }:
    let

        systemSettings = {
            system = "x86_64-linux";
            hostname = "nixos";
            timezone = "Asia/Kolkata";
            locale = "en_IN";
            kbLayout = "us";
            kbVariant = "colemak_dh";

            useSecureboot = false;
        };

        userSettings = {
            username = "pranavanath";
            gitUserName = "Nitrostation-Dev";
            gitUserEmail = "dev.nitrostation@gmail.com";
        };
        
        pkgs = import inputs.nixpkgs {
            system = systemSettings.system;
            config = {
                allowUnfree = true;
                allowUnfreePredicate = (_: true);
            };
        };
        lib = inputs.nixpkgs.lib;

    in {

        nixosConfigurations.${systemSettings.hostname} = lib.nixosSystem {
            system = systemSettings.system;
            modules = [
                ./hardware-configuration.nix
                ./config/configuration.nix
            ];
            specialArgs = {
                inherit inputs;
                inherit systemSettings;
                inherit userSettings;
            };
        };

        homeConfigurations.${userSettings.username} = inputs.home-manager.lib.homeManagerConfiguration {
            inherit pkgs;
            modules = [
                ./config/home.nix
            ];
            extraSpecialArgs = {
                inherit inputs;
                inherit systemSettings;
                inherit userSettings;
            };
        };
    };
}
