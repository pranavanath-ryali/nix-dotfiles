{ inputs, pkgs, config, userSettings, ... }:
{
    imports = [
        inputs.stylix.homeModules.stylix

        # ../../../../packages/home_packages/quickshell.nix
        ../../../../packages/home_packages/waybar.nix
    ];

    home.file.".config/waybar".source = ".dotfiles/themes/catppuccin-latte/waybar";

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

            kitty = {
                enable = true;
                variant256Colors = true;
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
