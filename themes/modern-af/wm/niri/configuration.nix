{ pkgs, systemSettings, inputs, ... }:
{
    imports = [
        inputs.stylix.nixosModules.stylix
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
                name = "DM Sans";
            };
            monospace = {
                package = pkgs.nerd-fonts.sauce-code-pro;
                name = "";
            };
            emoji = {
                package = pkgs.noto-fonts-color-emoji;
                name = "Noto Color Emoji";
            };
        };

        targets.gtk.enable = true;
        targets.qt.enable = true;
        targets.qt.platform = "qtct";

        targets.fish.enable = true;

        targets.plymouth.enable = false;
    };
}
