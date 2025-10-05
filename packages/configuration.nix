{ pkgs, ... }:
{
    imports = [
        ./system_packages/steam.nix
        ./system_packages/nh.nix
        ./system_packages/localsend.nix
        ./system_packages/syncthing.nix
        ./system_packages/flatpak.nix
    ];

    environment.systemPackages = with pkgs; [
        btop
        ranger
        grc
        ripgrep
        bat
        pciutils

        git
        gh

        vim
        wget
        curl
        unzip
        cmatrix

        gcc
        htop

        jack2
        qjackctl
    ];
}
