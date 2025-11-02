{ pkgs, userSettings, ... }:
{   
    imports = [
        (./. + "/packages/browser" + ("/" + userSettings.browser) + ".nix")
        
        ./packages/emacs.nix
        ./packages/nixvim.nix
        ./packages/neovide.nix
        ./packages/mpd.nix
        ./packages/rmpc.nix
        #./packages/gdlauncher.nix
        ./packages/prismlauncher.nix
    ];

    home.packages = with pkgs; [
        vscode
        calibre

        easyeffects
        strawberry
        lrcget

        bottles
    ];
}
