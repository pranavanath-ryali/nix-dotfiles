{ pkgs, userSettings, ... }:
{   
    imports = [
        (./. + "../../packages/browser" + ("/" + userSettings.browser) + ".nix")
        

        ./home_packages/emacs.nix
        ./home_packages/nixvim.nix
        ./home_packages/neovide.nix
        ./home_packages/mpd.nix
        ./home_packages/rmpc.nix
        # ./home_packages/retroarch.nix

        ./home_packages/gdlauncher.nix
    ];

    home.packages = with pkgs; [
        discord

        obsidian
        
        libresprite
        aseprite
        
        godot
        vscode

        easyeffects
        clementine
        lrcget

        bottles
    ];
}
