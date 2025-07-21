{ pkgs, userSettings, ... }:
{   
    imports = [
        (./. + "../../packages/browser" + ("/" + userSettings.browser) + ".nix")

        ./home_packages/nixvim.nix
        ./home_packages/neovide.nix
        ./home_packages/mpd.nix
        ./home_packages/rmpc.nix
        ./home_packages/retroarch.nix
    ];

    home.packages = with pkgs; [
        discord

        obsidian
        lorien

        vscode

        easyeffects
        # strawberry
        clementine

        bottles
    ];
}
