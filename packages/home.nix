{ pkgs, userSettings, ... }:
{   
    imports = [
        (./. + "../../packages/browser" + ("/" + userSettings.browser) + ".nix")

        ./home_packages/nixvim.nix
    ];

    home.packages = with pkgs; [
        vscode
        obsidian
    ];
}