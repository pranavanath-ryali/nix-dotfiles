{ inputs, config, pkgs, userSettings, ... }:
{
    imports = [
        inputs.stylix.nixosModules.stylix
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
        };

        autoEnable = false;

        targets.gtk.enable = true;
        targets.qt.enable = true;
        targets.qt.platform = "qtct";

        targets.fish.enable = true;

        targets.plymouth.enable = false;
    };
}
