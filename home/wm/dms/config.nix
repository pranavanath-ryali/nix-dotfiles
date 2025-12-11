{ config, lib, ... }:
{
    options = with lib; with types; {
        extra_niri_keybinds = mkOption { type = attrs; };
    };
    config = {
        extra_niri_keybinds = with config.lib.niri.actions; {
            "Mod+Space".action = spawn [ "dms" "ipc" "call" "spotlight" "toggle" ];
        };
    };
}
