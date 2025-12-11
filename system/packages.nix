{ pkgs, ... }:
{
    imports = [
        ./packages/emacs.nix
        ./packages/steam.nix
        ./packages/nh.nix
        ./packages/localsend.nix
        ./packages/syncthing.nix
        ./packages/flatpak.nix
    ];

    environment.systemPackages = with pkgs; [
        btop
        htop
        ranger
        grc
        ripgrep
        bat
        pciutils
        ispell

        git
        gh

        vim
        wget
        curl
        unzip
        cmatrix

        gcc

        jack2
        qjackctl
    ];
}
