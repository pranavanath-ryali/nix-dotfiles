{ inputs, lib, pkgs, config, userSettings, ... }:
{
    imports = [
        inputs.stylix.homeManagerModules.stylix
    ];

    stylix = {
        enable = true;

        polarity = "dark";
        base16Scheme = ../../base16.yaml;
        image = ../../wallpaper.png;

        fonts = {
            serif = {
                package = pkgs.ubuntu-sans;
                name = "Ubuntu Regular";
            };
            sansSerif = {
                package = pkgs.ubuntu-sans;
                name = "Ubuntu Regular";
            };
            monospace = {
                package = pkgs.nerd-fonts.ubuntu-sans;
                name = "UbuntuMono Nerd Font";
            };
            emoji = {
                package = pkgs.noto-fonts-emoji;
                name = "Noto Color Emoji";
            };
            sizes = "12";
        };

        # iconTheme = {
        #     enable = true;
        #     package = config.theme_stylix_icons_package;
        #     dark = config.theme_stylix_icons_dark;
        #     light = config.theme_stylix_icons_light;
        # };

        autoEnable = false;
        targets.vscode.enable = false;
    };
}