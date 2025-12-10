{ pkgs, userSettings, ... }:
{   
    imports = [
        (./. + "/packages/browser" + ("/" + userSettings.browser) + ".nix")
        
        ./packages/webapps.nix
        ./packages/browser/zen.nix
        ./packages/emacs.nix
        ./packages/nixvim.nix
        ./packages/neovide.nix
        ./packages/mpd.nix
        ./packages/rmpc.nix
        #./packages/gdlauncher.nix
        ./packages/prismlauncher.nix
        # ./packages/retroarch.nix
    ];

    home.packages = with pkgs; [
        planify
        overskride
        lazygit
        vscode

        calibre
    
        easyeffects
        strawberry
        lrcget

        bottles
    ];
}
