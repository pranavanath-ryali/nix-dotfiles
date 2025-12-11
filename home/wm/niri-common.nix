{ inputs, config, ... }:
{
    imports = [
        inputs.niri.homeModules.niri
    ];

    programs.niri.settings = {
        enable = true;
        prefer-no-csd = true;

        input = {
            keyboard = {
                numlock = true;
            };

            touchpad = {
                enable = true;
                dwt = true;

                accel-profile = "adaptive";
                accel-speed = 0.2;

                tap = true;
                tap-button-map = "left-right-middle";
                middle-emulation = true;
                click-method = "clickfinger";
                drag-lock = true;
                natural-scroll = true;
                scroll-method = "edge";
            };

            mouse = {
                accel-profile = "flat";
                accel-speed = 0.5;
            };
        };

        binds = with config.lib.niri.actions; {
            "Mod+E".action = spawn "nautilus";
            "Mod+Return".action = spawn "kitty";

            "Mod+Q".action = close-window;

            "Mod+A".action = focus-column-left;
            "Mod+S".action = focus-column-right;
            "Mod+R".action = focus-window-up;
            "Mod+C".action = focus-window-down;

            "Mod+Shift+A".action = move-column-left;
            "Mod+Shift+S".action = move-column-right;
            "Mod+Shift+R".action = move-column-to-workspace-up { focus = true; };
            "Mod+Shift+C".action = move-column-to-workspace-down { focus = true; };

            "Mod+Ctrl+Shift+A".action = consume-or-expel-window-left;
            "Mod+Ctrl+Shift+S".action = consume-or-expel-window-right;

            "Mod+Ctrl+A".action = set-column-width "-10%";
            "Mod+Ctrl+S".action = set-column-width "+10%";
            "Mod+Ctrl+R".action = set-window-height "+5%";
            "Mod+Ctrl+C".action = set-window-height "-5%";

            "Mod+F11".action = fullscreen-window;
            "Mod+M".action = maximize-column;
            "Mod+V".action = toggle-window-floating;
            "Mod+Shift+V".action = switch-focus-between-floating-and-tiling;
            "Mod+Shift+W".action = toggle-column-tabbed-display;

            "Mod+1".action = focus-workspace 1;
            "Mod+2".action = focus-workspace 2;
            "Mod+3".action = focus-workspace 3;
            "Mod+4".action = focus-workspace 4;
            "Mod+W".action = focus-workspace 5;
            "Mod+F".action = focus-workspace 6;
            "Mod+P".action = focus-workspace 7;

            "Mod+Shift+Slash".action = show-hotkey-overlay;

            "Mod+Grave".action = toggle-overview;
            "Mod+Shift+E".action = quit;

            "XF86AudioRaiseVolume".action = spawn ["wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "2%+"];
            "XF86AudioLowerVolume".action = spawn ["wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "2%-"];
            "XF86AudioMute".action = spawn ["wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle"];
            "XF86AudioMicMute".action = spawn ["wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle"];
            "XF86MonBrightnessUp".action = spawn ["brightnessctl" "s" "1%+"];
            "XF86MonBrightnessDown".action = spawn ["brightnessctl" "s" "1%-"];

            "XF86AudioPause".action = spawn ["playerctl" "play-pause"];
            "XF86AudioPlay".action = spawn ["playerctl" "play-pause"];
            "XF86AudioPrev".action = spawn ["playerctl" "previous"];
            "XF86AudioNext".action = spawn ["playerctl" "next"];

            "Mod+TouchpadScrollRight".action = focus-column-right;
            "Mod+TouchpadScrollLeft".action = focus-column-left;
            "Mod+TouchpadScrollUp".action = focus-workspace-up;
            "Mod+TouchpadScrollDown".action = focus-workspace-down;
            "Mod+TouchpadScrollRight".cooldown-ms = 200;
            "Mod+TouchpadScrollLeft".cooldown-ms = 200;
            "Mod+TouchpadScrollUp".cooldown-ms = 200;
            "Mod+TouchpadScrollDown".cooldown-ms = 200;

            "Print".action.screenshot = { show-pointer = false; };
            "Mod+Print".action.screenshot-screen = {};
            "Mod+Shift+Print".action.screenshot-window = {};
        } // config.extra_niri_keybinds;
    };
}
