{ inputs, pkgs, systemSettings, userSettings, ... }:
{
    imports = [
        ../packages/terminal/kitty.nix
        ../packages/vicinae.nix
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

    wayland.windowManager.hyprland = {
        enable = true;
        package = inputs.hyprland.packages.${systemSettings.system}.hyprland;
        portalPackage = inputs.hyprland.packages.${systemSettings.system}.xdg-desktop-portal-hyprland;

        settings = {
            monitor = [
                ",preferred,auto,1.0"
            ];

            env = [
                # "XCURSOR_SIZE,24"
                # "XCURSOR_THEME,Bibata-Modern-Classic"
            ];

            # exec-once = config.theme_hyprland_settings.exec-once;

            input = {
                kb_layout = systemSettings.kbLayout;
                kb_variant = systemSettings.kbVariant;

                numlock_by_default = true;

                follow_mouse = 1;
                sensitivity = 0.2;
                accel_profile = "0.2144477506 0.000 0.307 0.615 1.077 1.539 2.002 2.505 3.208 3.910 4.613 5.315 6.018 6.720 7.423 8.125 8.828 9.530 10.233 10.935 12.387";

                touchpad = {
                    natural_scroll = true;
                };
            };

            device = {
                name = "instant-usb-gaming-mouse-";
                accel_profile = "flat";
                sensitivity = -0.2;
            };

            general = {
                layout = "dwindle";
            };

            gesture = [
                "3, horizontal, workspace"
            ];

            dwindle = {
                pseudotile = true;
                preserve_split = true;
            };

            "$mainMod" = "SUPER";
            bind = [
                # General Bindings
                "$mainMod, Q, killactive,"
                "$mainMod, M, fullscreen, 1"
                "$mainMod, V, togglefloating,"
                "$mainMod, T, togglesplit,"

                "$mainMod SHIFT, DELETE, exit"

                "$mainMod, F11, fullscreen,"
                "$mainMod SHIFT, F11, fullscreenstate, 0 2"

                # TODO: Screenshots
                # "$mainMod SHIFT, PRINT, exec, hyprshot -m region -o /home/${userSettings.username}/Pictures/Screenshots/"
                # ", PRINT, exec, hyprshot -m active -m output -o /home/${userSettings.username}/Pictures/Screenshots/"

                # Application Bindings
                "$mainMod, RETURN, exec, kitty"
                "$mainMod, E, exec, nautilus"

                # TODO: Application launcher "$mainMod, R, exec, rofi -show drun"

                "$mainMod, 1, workspace, 1"
                "$mainMod, 2, workspace, 2"
                "$mainMod, 3, workspace, 3"
                "$mainMod, 4, workspace, 4"
                "$mainMod, 5, workspace, 5"
                "$mainMod, F, workspace, 6"
                "$mainMod, P, workspace, 7"

                "$mainMod CONTROL SHIFT, 1, movetoworkspace, 1"
                "$mainMod CONTROL SHIFT, 2, movetoworkspace, 2"
                "$mainMod CONTROL SHIFT, 3, movetoworkspace, 3"
                "$mainMod CONTROL SHIFT, 4, movetoworkspace, 4"
                "$mainMod CONTROL SHIFT, 5, movetoworkspace, 5"
                "$mainMod CONTROL SHIFT, F, movetoworkspace, 6"
                "$mainMod CONTROL SHIFT, P, movetoworkspace, 7"

                "$mainMod, S, movefocus, r"
                "$mainMod, A, movefocus, l"
                "$mainMod, W, movefocus, u"
                "$mainMod, R, movefocus, d"

                "$mainMod SHIFT, S, movewindoworgroup, r"
                "$mainMod SHIFT, A, movewindoworgroup, l"
                "$mainMod SHIFT, W, movewindoworgroup, u"
                "$mainMod SHIFT, R, movewindoworgroup, d"

                "$mainMod CONTROL SHIFT, S, moveintogroup, r"
                "$mainMod CONTROL SHIFT, A, moveintogroup, l"
                "$mainMod CONTROL SHIFT, W, moveintogroup, u"
                "$mainMod CONTROL SHIFT, R, moveintogroup, d"

                "$mainMod, GRAVE, togglegroup"
                "$mainMod, TAB, changegroupactive, f"
                "$mainMod SHIFT, TAB, changegroupactive, b"

                "$mainMod, mouse_down, workspace, e-1"
                "$mainMod, mouse_up, workspace, e-1"
                "$mainMod SHIFT, mouse_down, layoutmsg, move -col"
                "$mainMod SHIFT, mouse_up, layoutmsg, move +col"
            ];

            binde = [
                "$mainMod CONTROL, A, resizeactive, -20 0"
                "$mainMod CONTROL, S, resizeactive, 20 0"
                "$mainMod CONTROL, W, resizeactive, 0 -20"
                "$mainMod CONTROL, R, resizeactive, 0 20"
            ];

            bindel = [
                ",XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%+"
                ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%-"
                ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
                ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
                ",XF86MonBrightnessUp, exec, brightnessctl s 1%+"
                ",XF86MonBrightnessDown, exec, brightnessctl s 1%-"
            ];

            bindl = [
                ", XF86AudioNext, exec, playerctl next"
                ", XF86AudioPause, exec, playerctl play-pause"
                ", XF86AudioPlay, exec, playerctl play-pause"
                ", XF86AudioPrev, exec, playerctl previous"
            ];

            bindm = [
                "$mainMod, mouse:272, movewindow"
                "$mainMod, mouse:273, resizewindow"
            ];

            windowrulev2 = [
            ];
        };
    };
}
