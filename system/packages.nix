{ pkgs, ... }:
{
    imports = [
        ./packages/emacs.nix
        ./packages/steam.nix
        ./packages/nh.nix
        ./packages/localsend.nix
        ./packages/syncthing.nix
        ./packages/virtualization.nix
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
