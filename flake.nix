{
    description = "NixOS Dotfiles";

    outputs = inputs@{ self, ... }:
    let
        systemSettings = {
            system = "x86_64-linux";
            hostname = "zeus";
            timezone = "Asia/Kolkata";
            locale = "en_IN";
            kbLayout = "us";
            kbVariant = "colemak_dh";

            useSecureboot = false;

            swapSizeInGb = 22;

            enablePlymouth = true;
            plymouthTheme = "hexagon_dots";
        };

        userSettings = {
            username = "pranavanath";
            gitUserName = "Nitrostation-Dev";
            gitUserEmail = "dev.nitrostation@gmail.com";

            wm = "hyprland";
            theme = "catppuccin-mocha";
            browser = "firefox";

            musicDir = "/mnt/local_disk/music";
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

        devShells.${systemSettings.system}.default = pkgs.mkShell {
            name = "nix dev shell";

            buildInputs = with pkgs; [
                nixd
                nixfmt-rfc-style
            ];

            shellHook = ''
                echo "NixOS Development Environment"
            '';
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
        hyprland.inputs.nixpkgs.follows = "nixpkgs";

        # Hyprland Plugins
        hyprland-plugins.url = "github:hyprwm/hyprland-plugins";
        hyprland-plugins.inputs.hyprland.follows = "hyprland";

        # Niri
        niri.url = "github:sodiboo/niri-flake";
        niri.inputs.hyprland.follows = "nixpkgs";
        
        # Plugins
        hypr-dynamic-cursors.url = "github:VirtCode/hypr-dynamic-cursors";
        hypr-dynamic-cursors.inputs.hyprland.follows = "hyprland";

        # Stylix
        stylix.url = "github:danth/stylix";
        stylix.inputs.nixpkgs.follows = "nixpkgs";

        # NixVim
        nixvim.url = "github:nix-community/nixvim";
        nixvim.inputs.nixpkgs.follows = "nixpkgs";

        # Zen Browser
        zen-browser.url = "github:0xc000022070/zen-browser-flake/beta";
        zen-browser.inputs.nixpkgs.follows = "nixpkgs";
    };
}
