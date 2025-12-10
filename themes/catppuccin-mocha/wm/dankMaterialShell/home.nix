{ inputs, pkgs, config, userSettings, ... }:
{
    imports = [
        inputs.stylix.homeModules.stylix
    ];

    stylix = {
        enable = true;
        base16Scheme = ../../base16.yaml;

        fonts = {
            serif = {
                package = pkgs.dm-sans;
                name = "DeepMind Sans";
            };
            sansSerif = {
                package = pkgs.dm-sans;
                name = "DM Sans";
            };
            monospace = {
                package = pkgs.nerd-fonts.mononoki;
                name = "Mononoki NF";
            };
            emoji = {
                package = pkgs.noto-fonts-color-emoji;
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

        opacity = {
            applications = 1.0;
            desktop = 1.0;
            popups = 1.0;
            terminal = 1.0;
        };

        autoEnable = false;
    };
}
