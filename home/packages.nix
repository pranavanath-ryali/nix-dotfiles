{ pkgs, userSettings, ... }:
{   
    imports = [
        (./. + "/packages/browser" + ("/" + userSettings.browser) + ".nix")
        
        ./packages/direnv.nix
        ./packages/webapps.nix
        ./packages/emacs.nix
        ./packages/nixvim.nix
        ./packages/neovide.nix
        ./packages/rmpc.nix
        #./packages/gdlauncher.nix
        ./packages/prismlauncher.nix
        ./packages/activitywatch.nix
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
