{ inputs, pkgs, config, userSettings, ... }:
{
    imports = [
        inputs.stylix.homeModules.stylix

        ../../../../packages/home_packages/rofi.nix
    ];

    stylix = {
        enable = true;

        polarity = "dark";
        base16Scheme = ../../base16.yaml;
        image = ../../wallpaper.png;

        fonts = {
            serif = {
                package = pkgs.maple-mono.NF;
                name = "MapleMono NF";
            };
            sansSerif = {
                package = pkgs.maple-mono.NF;
                name = "MapleMono NF";
            };
            monospace = {
                package = pkgs.maple-mono.NF;
                name = "MapleMono NF";
            };
            emoji = {
                package = pkgs.nerd-fonts.ubuntu-sans;
                name = "UbuntuSansMono Nerd Font";
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

        opacity = {
            applications = 1.0;
            desktop = 1.0;
            popups = 1.0;
            terminal = 1.0;
        };

        autoEnable = false;
        targets = {
            gtk.enable = true;
            gtk.flatpakSupport.enable = true;
            qt.enable = true;
            qt.platform = "qtct";

            hyprland.enable = true;
            hyprland.hyprpaper.enable = true;
            hyprpaper.enable = true;

            hyprlock.enable = true;
            hyprlock.useWallpaper = config.stylix.image != null;

            fish.enable = true;

            kitty = {
                enable = true;
                variant256Colors = false;
            };

            firefox = {
                enable = true;
                colorTheme.enable = true;
                firefoxGnomeTheme.enable = true;

                profileNames = [ "my-profile" ];
            };

            neovide.enable = true;
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
