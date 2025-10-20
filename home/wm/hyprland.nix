{ lib, inputs, config, pkgs, userSettings, systemSettings, ... }:
let
    hyprland_settings = {
        monitor = [
            ",preferred,auto,1.0"
        ];

        env = [
            "XCURSOR_SIZE,28"
            "HYPRCURSOR_SIZE,28"
        ];

        exec-once = [
            "hyprctl setcursor Adwaita 28"
        ] ++ config.theme_hyprland_settings.exec-once;

        input = {
            kb_layout = systemSettings.kbLayout;
            kb_variant = systemSettings.kbVariant;
            kb_options = "caps:swapecape";

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
            layout = "scrolling";
        } // config.theme_hyprland_settings.general;

        gesture = [
            "3, vertical, workspace"
        ];

        dwindle = {
            pseudotile = true;
            preserve_split = true;
        };
        #
        # master = {
        #     new_status = "master";
        # };

        plugin = {
            hyprscrolling = {
                fullscreen_on_one_column = false;
                column_width = 0.75;
                focus_fit_method = 1;
                follow_focus = true;
            };
        };

        "$mainMod" = "SUPER";
        bind = [
            # General Bindings
            "$mainMod, Q, killactive,"
            "$mainMod, M, fullscreen, 1"
            "$mainMod, V, togglefloating,"
            "$mainMod, GRAVE, togglesplit,"

            "$mainMod SHIFT, DELETE, exit"

            "$mainMod, F11, fullscreen,"
            "$mainMod SHIFT, F11, fullscreenstate, 0 2"

            "$mainMod, O, exec, obsidian"

            # Screenshots
            "$mainMod SHIFT, PRINT, exec, hyprshot -m region -o /home/${userSettings.username}/Pictures/Screenshots/"
            ", PRINT, exec, hyprshot -m active -m output -o /home/${userSettings.username}/Pictures/Screenshots/"

            # Application Bindings
            "$mainMod, RETURN, exec, kitty"
            "$mainMod, E, exec, nautilus"

            "$mainMod, R, exec, rofi -show drun"
            "$mainMod SHIFT, E, exec, rofi -show filebrowser"

            # Window Focus Bindings
            "ALT, TAB, cyclenext,"
            "ALT SHIFT, TAB, cyclenext, prev"

            # "$mainMod, left, movefocus, l"
            # "$mainMod, right, movefocus, r"

            # Window Move Bindings

            # Window Resize Bindings
            # "$mainMod CTRL, left, resizeactive, -50 0"
            # "$mainMod CTRL, right, resizeactive, 50 0"

            # Workspace Bindings
            "$mainMod, 1, workspace, 1"
            "$mainMod, 2, workspace, 2"
            "$mainMod, 3, workspace, 3"
            "$mainMod, 4, workspace, 4"
            "$mainMod, W, workspace, 5"
            "$mainMod, F, workspace, 6"
            "$mainMod, P, workspace, 7"
            # "$mainMod, 8, workspace, 8"
            # "$mainMod, 9, workspace, 9"
            # "$mainMod, 0, workspace, 10"

            # "$mainMod SHIFT, 1, movetoworkspace, 1"
            # "$mainMod SHIFT, 2, movetoworkspace, 2"
            # "$mainMod SHIFT, 3, movetoworkspace, 3"
            # "$mainMod SHIFT, 4, movetoworkspace, 4"
            # "$mainMod SHIFT, W, movetoworkspace, 5"
            # "$mainMod SHIFT, F, movetoworkspace, 6"
            # "$mainMod SHIFT, P, movetoworkspace, 7"
            # "$mainMod SHIFT, 8, movetoworkspace, 8"
            # "$mainMod SHIFT, 9, movetoworkspace, 9"
            # "$mainMod SHIFT, 0, movetoworkspace, 10"

            "$mainMod, S, togglespecialworkspace, scratchpad"
            "$mainMod SHIFT, S, movetoworkspace, special:scratchpad"

            # Hyprscrolling Bindings
            "$mainMod, right, layoutmsg, move +col"
            "$mainMod, left, layoutmsg, move -col"
            "$mainMod, up, movefocus, u"
            "$mainMod, down, movefocus, d"

            "$mainMod SHIFT, right, layoutmsg, movewindowto r"
            "$mainMod SHIFT, left, layoutmsg, movewindowto l"
            "$mainMod SHIFT, up, layoutmsg, movewindowto u"
            "$mainMod SHIFT, down, layoutmsg, movewindowto d"

            "$mainMod CTRL, LEFT, layoutmsg, colresize -0.25"
            "$mainMod CTRL, RIGHT, layoutmsg, colresize +0.25"
            "$mainMod CTRL, up, resizeactive, 0 50"
            "$mainMod CTRL, down, resizeactive, 0 -50"

            "$mainMod SHIFT CTRL, LEFT, layoutmsg, swapcol l"
            "$mainMod SHIFT CTRL, RIGHT, layoutmsg, swapcol r"

            "$mainMod SHIFT, 1, layoutmsg, movecoltoworkspace 1"
            "$mainMod SHIFT, 2, layoutmsg, movecoltoworkspace 2"
            "$mainMod SHIFT, 3, layoutmsg, movecoltoworkspace 3"
            "$mainMod SHIFT, 4, layoutmsg, movecoltoworkspace 4"
            "$mainMod SHIFT, W, layoutmsg, movecoltoworkspace 5"
            "$mainMod SHIFT, F, layoutmsg, movecoltoworkspace 6"
            "$mainMod SHIFT, P, layoutmsg, movecoltoworkspace 7"

            "$mainMod, mouse_down, workspace, e-1"
            "$mainMod, mouse_up, workspace, e-1"
            "$mainMod SHIFT, mouse_down, layoutmsg, move -col"
            "$mainMod SHIFT, mouse_up, layoutmsg, move +col"


        ] ++ config.theme_hyprland_settings.bind;

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
            "float, class:org.gnome.Nautilus"
            "float, class:org.pulseaudio.pavucontrol"
            "float, class:.blueman-manager-wrapped"
            "float, class:qimgv"

            "size 1200 800, class:org.gnome.Nautilus"
            "size 200 500, class:org.gnome.Calculator"
            "size 500 500, class:org.pulseaudio.pavucontrol"
            "size 500 500, class:.blueman-manager-wrapped"

            "opacity 1.0, fullscreen:1"
        ];
    };
in
{
    imports = [
        ../../packages/terminal/kitty.nix
        ../../packages/home_packages/fish.nix
        ../../packages/home_packages/zathura.nix
        ../../packages/home_packages/qimgv.nix
        ../../packages/home_packages/mpv.nix
    ];

    home.packages = with pkgs; [
        wl-clipboard
        
        pavucontrol
        playerctl
        brightnessctl

        wlogout
        hyprshot

        hyprpaper

        nautilus
        file-roller
        gnome-clocks
        gnome-calculator
        gnome-disk-utility
    ];
    
    # HYPRLAND CONFIG
    wayland.windowManager.hyprland = {
        enable = true;

        package = inputs.hyprland.packages.${systemSettings.system}.hyprland;
        portalPackage = inputs.hyprland.packages.${systemSettings.system}.xdg-desktop-portal-hyprland;

        settings = lib.mkForce (config.theme_hyprland_settings // hyprland_settings);
        
        plugins = with inputs.hyprland-plugins.packages.${systemSettings.system}; [
            hyprscrolling
        ] ++ [
            inputs.hypr-dynamic-cursors.packages.${systemSettings.system}.hypr-dynamic-cursors
        ];
    };

    # HYPRIDLE CONFIG
    services.hypridle = {
        enable = true;
        package = pkgs.hypridle;
        settings = {
            general = {
                lock_cmd = "pidof hyprlock || hyprlock";
                before_sleep_cmd = "loginctl lock-session";
                after_sleep_cmd = "hyprctl dispatch dpms on";
            };

            listener = [
                {
                    timeout = 180;
                    on-timeout = "brightnessctl -s set 10";
                    on-resume = "brightnessctl -r";
                }
                { 
                    timeout = 180;
                    on-timeout = "brightnessctl -sd rgb:kbd_backlight set 0";
                    on-resume = "brightnessctl -rd rgb:kbd_backlight";
                }
                {
                    timeout = 240;
                    on-timeout = "loginctl lock-session";
                }
                {
                    timeout = 300;
                    on-timeout = "hyprctl dispatch dpms off";
                    on-resume = "hyprctl dispatch dpms on";
                }
                {
                    timeout = 330;
                    on-timeout = "systemctl suspend";
                }
            ];
        };
    };

    # HYPRLOCK CONFIG
    programs.hyprlock = {
        enable = true;
        package = pkgs.hyprlock;
        # settings = {};
    };
}
