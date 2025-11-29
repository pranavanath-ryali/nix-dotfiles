{ pkgs, systemSettings, inputs, ... }:
{
    imports = [
        inputs.stylix.nixosModules.stylix
    ];

    environment.systemPackages = [ pkgs.libsForQt5.qtstyleplugin-kvantum ];

    stylix = {
        enable = true;

        polarity = "dark";
        base16Scheme = ../../dark.yaml;
        image = ../../dark.jpeg;

        fonts = {
            serif = {
                package = pkgs.inter;
                name = "Inter Regular";
            };
            sansSerif = {
                package = pkgs.inter;
                name = "Inter Display";
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

        targets.gtk.enable = false;
        targets.qt.enable = true;
        targets.qt.platform = "qtct";

        targets.fish.enable = true;

        targets.plymouth.enable = false;
    };
}
