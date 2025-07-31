{ inputs, config, pkgs, userSettings, ... }:
{
    imports = [
        inputs.stylix.nixosModules.stylix
    ];

    stylix = {
        enable = true;

        polarity = "light";
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
        };

        cursor = {
            package = pkgs.catppuccin-cursors.latteLight;
            name = "catppuccin-latte-light-cursors";
            size = 24;
        };

        targets.gtk.enable = true;
        targets.qt.enable = true;
        # targets.qt.platform = "qtct";

        targets.fish.enable = true;
    };
}
