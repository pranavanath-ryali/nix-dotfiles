{ pkgs, inputs, ... }:
{
    imports = [
        inputs.stylix.homeModules.stylix
    ];

    home.packages = with pkgs; [
        pkgs.libsForQt5.qtstyleplugin-kvantum
    ];

    stylix = {
        enable = true;

        polarity = "dark";
        base16Scheme = ../../dark.yaml;
        image = ../../dark.jpeg;

        fonts = {
            serif = {
                package = pkgs.inter;
                name = "";
            };
            sansSerif = {
                package = pkgs.inter;
                name = "";
            };
            monospace = {
                package = pkgs.maple-mono.NF;
                name = "";
            };
            emoji = {
                package = pkgs.noto-fonts-color-emoji;
                name = "";
            };
            sizes = {
                applications = 11;
                desktop = 11;
                popups = 11;
                terminal = 12;
            };
        };

        # iconTheme = {
        #     enable = true;
        #     package = pkgs.catppuccin-papirus-folders;
        #     dark = "Papirus-Dark";
        #     light = "Papirus-Light";
        # };

        # opacity = {
        #     applications = 1.0;
        #     desktop = 1.0;
        #     popups = 1.0;
        #     terminal = 1.0;
        # };

        autoEnable = false;
        targets = {
            gtk.enable = false;
            gtk.flatpakSupport.enable = false;

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

            # firefox = {
            #     enable = true;
            #     colorTheme.enable = true;
            #     firefoxGnomeTheme.enable = true;
            #
            #     profileNames = [ "my-profile" ];
            # };

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
