{ pkgs, inputs, ... }:
{
    imports = [
        inputs.stylix.homeModules.stylix
    ];

    stylix = {
        enable = true;

        polarity = "dark";
        base16Scheme = ../../dark.yaml;
        image = ../../dark.jpeg;

        fonts = {
            serif = {
                package = pkgs.dm-sans;
                name = "DeepMind Sans";
            };
            sansSerif = {
                package = pkgs.dm-sans;
                name = "DeepMind Sans";
            };
            monospace = {
                package = pkgs.nerd-fonts.sauce-code-pro;
                name = "SauceCodePro NF";
            };
            emoji = {
                package = pkgs.noto-fonts-color-emoji;
                name = "Noto Color Emoji";
            };
            sizes = {
                applications = 12;
                desktop = 12;
                popups = 12;
                terminal = 12;
            };
        };

        iconTheme = {
            enable = true;
            # package = (import ../../packages/vinceliuice-mactahoe-icon-theme.nix { inherit pkgs; inherit lib; });
            package = (
                import ../../packages/vinceliuice-mactahoe-icon-theme.nix {
                    inherit pkgs;
                    stdenv = pkgs.stdenv;
                    lib = pkgs.lib;
                    fetchFromGithub = pkgs.fetchFromGitHub;
                }
            );
            dark = "MacTahoe-dark";
            light = "MacTahoe-light";
        };

        # opacity = {
        #     applications = 1.0;
        #     desktop = 1.0;
        #     popups = 1.0;
        #     terminal = 1.0;
        # };

        autoEnable = false;
        targets = {
            gtk.enable = true;
            gtk.flatpakSupport.enable = true;

            qt.enable = true;
            qt.platform = "qtct";

            # hyprland.enable = true;
            # hyprland.hyprpaper.enable = true;
            # hyprpaper.enable = true;
            #
            # hyprlock.enable = true;
            # hyprlock.useWallpaper = config.stylix.image != null;

            fish.enable = true;
            kitty = {
                enable = true;
                variant256Colors = false;
            };

            neovide.enable = false;
            nixvim = {
                enable = true;
                plugin = "mini.base16";
                transparentBackground = {
                    main = true;
                    numberLine = true;
                    signColumn = true;
                };
            };
        };
    };
}
