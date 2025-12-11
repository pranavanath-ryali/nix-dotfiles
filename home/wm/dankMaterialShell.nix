{ inputs, pkgs, ... }:
{
    imports = [
        ./niri-common.nix
        ./dms/config.nix
        inputs.dankMaterialShell.homeModules.dankMaterialShell.default
        inputs.dankMaterialShell.homeModules.dankMaterialShell.niri
        
        ../packages/terminal/kitty.nix
        ../../home/packages/mpv.nix
    ];

    home.packages = with pkgs; [
        pwvucontrol

        nautilus
        papers
        file-roller
        loupe

        playerctl
        brightnessctl
    ];

    programs.dankMaterialShell = {
        enable = true;
        niri = {
            enableKeybinds = false;
            enableSpawn = true;
        };
    };
}
