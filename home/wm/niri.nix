{ inputs, pkgs, config, ... }:
{
    imports = [
        ./niri-common.nix

        ../packages/terminal/kitty.nix
        ../../home/packages/mpv.nix
    ];

    home.packages = with pkgs; [
        pwvucontrol

        nautilus
        papers
        file-roller
        loupe

        swaylock
        wl-clipboard
        playerctl
        brightnessctl
    ];
}
