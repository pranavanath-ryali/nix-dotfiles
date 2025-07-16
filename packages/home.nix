{ pkgs, userSettings, ... }:
{   
    imports = [
        (./. + "../../packages/browser" + ("/" + userSettings.browser) + ".nix")

        ./home_packages/nixvim.nix
    ];

    home.packages = with pkgs; [
        discord

        obsidian
        lorien

        vscode

        easyeffects
        strawberry

        gnome-clocks
        gnome-calculator
    ];
}