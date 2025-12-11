{ inputs, pkgs, lib, config, ... }:
{
    imports = [
        ./niri-common.nix
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

    options = with lib; with types; {
        extra_niri_keybinds = mkOption { type = attrs; };
    }
    config = {
        extra_niri_keybinds = with config.lib.niri.actions; {
            "Mod+Space".action = spawn [ "dms" "ipc" "call" "spotlight" "toggle" ];
        };
    };
}
