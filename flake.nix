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

            enableHibernation = true;
            swapSizeInGb = 22;

            useSecureboot = false;
        };

        userSettings = {
            username = "pranavanath";
            gitUserName = "Nitrostation-Dev";
            gitUserEmail = "dev.nitrostation@gmail.com";

            wm = "niri";
            theme = "rice0";
            browser = "zen";

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
        nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-25.11";

        # Home Manager (Standalone Installation)
        home-manager.url = "github:nix-community/home-manager/release-25.11";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";

        # Hyprland
        hyprland.url = "github:hyprwm/Hyprland";
        hyprland.inputs.nixpkgs.follows = "nixpkgs";

        # Hyprland Plugins
        hyprland-plugins.url = "github:hyprwm/hyprland-plugins";
        hyprland-plugins.inputs.hyprland.follows = "hyprland";

        hy3.url = "github:outfoxxed/hy3";
        hy3.inputs.hyprland.follows = "hyprland";

        # Niri
        niri.url = "github:sodiboo/niri-flake";
        niri.inputs.nixpkgs.follows = "nixpkgs";

        # Dank Material Shell
        dankMaterialShell.url = "github:AvengeMedia/DankMaterialShell/stable";
        dankMaterialShell.inputs.nixpkgs.follows = "nixpkgs";

        # Stylix
        stylix.url = "github:danth/stylix";
        stylix.inputs.nixpkgs.follows = "nixpkgs";

        # Matugen   
        matugen.url = "github:/InioX/Matugen";
        matugen.inputs.nixpkgs.follows = "nixpkgs";

        # Plugins
        hypr-dynamic-cursors.url = "github:VirtCode/hypr-dynamic-cursors";
        hypr-dynamic-cursors.inputs.hyprland.follows = "hyprland";

        # NixVim
        nixvim.url = "github:nix-community/nixvim/nixos-25.11";
        nixvim.inputs.nixpkgs.follows = "nixpkgs";

        # Zen Browser
        zen-browser.url = "github:0xc000022070/zen-browser-flake/beta";
        zen-browser.inputs.nixpkgs.follows = "nixpkgs";

        # Vicinae
        vicinae.url = "github:vicinaehq/vicinae";
        # vicinae.inputs.nixpkgs.follows = "nixpkgs";

        vicinae-extensions.url = "github:vicinaehq/extensions";
        vicinae-extensions.inputs.nixpkgs.follows = "nixpkgs";

        # AWWW
        awww.url = "git+https://codeberg.org/LGFae/awww";
    };
}
