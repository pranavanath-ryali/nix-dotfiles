{ config, lib, userSettings, ... }:
{
    options = with lib; with types; {
        theme_hyprland_settings = mkOption { type = attrs; };
    };

    config = {
        theme_hyprland_settings = {
            exec-once = [];

            general = {
                gaps_in = 5;
                gaps_out = 10;
                border_size = 0;
                gaps_workspaces = 0;

                resize_on_border = true;
                allow_tearing = false;
                layout = "dwindle";
            };

            decoration = {
                rounding = 12;
                rounding_power = 2.0;

                active_opacity = 1.0;
                inactive_opacity = 1.0;
                fullscreen_opacity = 1.0;

                dim_inactive = true;
                dim_strength = 0.12;
                dim_special = 0.5;

                shadow = {
                    enabled = true;
                    range = 10;
                    render_power = 4;
                    ignore_window = true;
                    color = "rgba(4c4f69ff)";
                };

                blur = {
                    enabled = false;
                    new_optimizations = true;
                    size = 2;
                    passes = 2;
                    vibrancy = 0.169;
                    ignore_opacity = true;

                    special = false;
                };
            };

            animations = {
                enabled = true;

                bezier = [
                    "wind, 0.05, 0.9, 0.1, 1.05"
                    "winIn, 0.1, 1.1, 0.1, 1.1"
                    "winOut, 0.3, -0.3, 0, 1"
                    "liner, 1, 1, 1, 1"
                ];

                animation = [
                    "windows, 1, 6, wind, slide"
                    "windowsIn, 1, 6, winIn, slide"
                    "windowsOut, 1, 5, winOut, slide"
                    "windowsMove, 1, 5, wind, slide"
                    "border, 1, 1, liner"
                    "borderangle, 1, 30, liner, loop"
                    "fade, 1, 10, default"
                    "workspaces, 1, 5, wind"
                ];
            };

            bind = [];
        };
    };
}