{
    description = "NixOS Dotfiles";

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

            wm = "gnome";
            theme = "default";
            browser = "firefox";

            musicDir = "/mnt/Local Disk/Music - new/";
        };
        
        pkgs = import inputs.nixpkgs {
            system = systemSettings.system;
            config = {
                allowUnfree = true;
                allowUnfreePredicate = (_: true);

                android_sdk.accept_license = true;
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

    inputs = {
        # Nixpkgs
        nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

        # Home Manager (Standalone Installation)
        home-manager.url = "github:nix-community/home-manager/master";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";

        # Hyprland
        hyprland.url = "github:hyprwm/Hyprland";

        # Stylix
        stylix.url = "github:danth/stylix";
        stylix.inputs.nixpkgs.follows = "nixpkgs";

        # Quickshell
        quickshell.url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
        quickshell.inputs.nixpkgs.follows = "nixpkgs";

        # NixVim
        nixvim.url = "github:nix-community/nixvim";
        nixvim.inputs.nixpkgs.follows = "nixpkgs";
    };
}
