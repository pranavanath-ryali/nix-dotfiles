{ inputs, config, pkgs, userSettings, ... }:
{
    imports = [
        inputs.stylix.nixosModules.stylix
    ];

    stylix = {
        enable = true;

        polarity = "dark";
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
        };

        autoEnable = false;

        targets.gtk.enable = true;
        targets.qt.enable = true;
        targets.qt.platform = "qtct";
    };
}
