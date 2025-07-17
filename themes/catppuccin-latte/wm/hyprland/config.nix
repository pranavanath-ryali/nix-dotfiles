{ config, lib, userSettings, ... }:
{
    options = with lib; with types; {
        theme_hyprland_settings = mkOption { type = attrs; };
    };

    config = {
        theme_hyprland_settings = {
            exec-once = [];

            general = {
                gaps_in = 4;
                gaps_out = 8;
                border_size = 3;

                resize_on_border = false;
                allow_tearing = false;
                layout = "dwindle";

                "col.active_border" = "rgba(eff1f5ff)";
                "col.inactive_border" = "rgba(dce0e8ff)";
            };

            decoration = {
                rounding = 12;
                active_opacity = 1.0;
                inactive_opacity = 1.0;

                shadow = {
                    enabled = true;
                    range = 4;
                    render_power = 3;
                    color = "rgba(4c4f69ff)";
                };

                blur = {
                    enabled = true;
                    size = 3;
                    passes = 1;
                    vibrancy = 0.1696;
                };
            };

            dwindle = {
                pseudotile = true;
                preserve_split = true;
            };

            master = {
                new_status = "master";
            };

            bind = [];
        };
    };
}