{ config, lib, userSettings, ... }:
{
    options = with lib; with types; {
        theme_niri_settings = mkOption { type = attrs; };
        theme_kitty_settings = mkOption { type = attrs; };
    };

    config = {
        theme_niri_settings = {
            layout = {
                gaps = 8;

                border = {
                    enable = true;
                    width = 2;
                    active = "rgba(255, 255, 255, 255)";
                    urgent = "rgba(255, 0, 0, 255)";
                    inactive = "rgba(0, 0, 0, 0)";
                };
            };
        };

        theme_kitty_settings = {
            extraConfig = ''
font_size 12

window_padding_width 2 2

background_opacity 1.0

cursor_trail 1
            '';
            # themeFile = "Catppuccin-Mocha";
        };
    };
}
