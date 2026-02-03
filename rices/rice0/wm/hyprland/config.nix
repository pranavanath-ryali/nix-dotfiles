{ lib, ... }:
{
    options = with lib; with types; {
        theme_kitty_settings = mkOption { type = attrs; };
    };
    config = {
        theme_kitty_settings = {
            extraConfig = ''
font_size 12
window_padding_width 6 6
background_opacity 0.7
cursor_trail 1
hide_window_decorations yes
            '';
        };
    };
}
