{ config, lib, userSettings, ... }:
{
    options = with lib; with types; {
        theme_kitty_settings = mkOption { type = attrs; };
    };

    config = {
        theme_kitty_settings = {
            extraConfig = ''
font_size 12

window_padding_width 2 2

background_opacity 1.0

cursor_trail 1
            '';
        };
    };
}
