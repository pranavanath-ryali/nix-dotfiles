{ pkgs, ... }:
{
    imports = [
        ./system_packages/steam.nix
        ./system_packages/nh.nix
        ./system_packages/localsend.nix
        ./system_packages/syncthing.nix
    ];

    environment.systemPackages = with pkgs; [
        vim
        ranger
        wget
        curl
        unzip

        git
        gh

        jq
        socat
        ripgrep
        fd
        gcc
        sass
        htop
        bat
        grc
        cargo
    ];
}
