{ inputs, pkgs, config, userSettings, ... }:
{
    imports = [
        inputs.stylix.homeModules.stylix
    ];

    stylix = {
        enable = true;

        polarity = "light";
        base16Scheme = ../../base16.yaml;
        image = ../../wallpaper.png;

        fonts = {
            serif = {
                package = pkgs.ubuntu-sans;
                name = "UbuntuSans";
            };
            sansSerif = {
                package = pkgs.ubuntu-sans;
                name = "UbuntuSans";
            };
            monospace = {
                package = pkgs.nerd-fonts.ubuntu-sans;
                name = "UbuntuSansMono Nerd Font";
            };
            emoji = {
                package = pkgs.noto-fonts-emoji;
                name = "Noto Color Emoji";
            };
            sizes = {
                applications = 11;
                desktop = 11;
                popups = 11;
                terminal = 12;
            };
        };

        iconTheme = {
            enable = true;
            package = pkgs.catppuccin-papirus-folders;
            dark = "Papirus-Dark";
            light = "Papirus-Light";
        };

        cursor = {
            package = pkgs.catppuccin-cursors.latteLight;
            name = "Catppuccin Cursor";
            size = 12;
        };

        autoEnable = false;
        targets = {
            gtk.enable = true;
            gtk.flatpakSupport.enable = true;
            qt.enable = true;
            qt.platform = "qtct";

            fish.enable = true;

            firefox = {
                enable = true;
                colorTheme.enable = true;
                firefoxGnomeTheme.enable = true;

                profileNames = [ "my-profile" ];
            };

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
