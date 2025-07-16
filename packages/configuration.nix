{ pkgs, ... }:
{
    imports = [
        ./system_packages/nh.nix
    ];

    environment.systemPackages = with pkgs; [
        vim
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