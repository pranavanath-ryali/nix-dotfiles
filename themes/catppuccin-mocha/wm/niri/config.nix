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
                    active.color = "rgba(255, 255, 255, 255)";
                    urgent.color = "rgba(255, 0, 0, 255)";
                };

                focus-ring.enable = false;
            };

            window-rules = [
                {
                    matches = [];
                    clip-to-geometry = true;
                    geometry-corner-radius = {
                        bottom-left = 6.0;
                        bottom-right = 6.0;
                        top-left = 6.0;
                        top-right = 6.0;
                    };
                }
            ];
        };

        theme_kitty_settings = {
            extraConfig = ''
font_size 12

window_padding_width 2 2

background_opacity 1.0

cursor_trail 1

hide_window_decorations yes
            '';
            # themeFile = "Catppuccin-Mocha";
        };
    };
}
