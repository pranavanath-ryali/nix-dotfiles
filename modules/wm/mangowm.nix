{ userSettings, ... }:
{
  flake.nixosModules.mangowmModule = { inputs, pkgs, ... }: {
    imports = [
      inputs.mangowm.nixosModules.mango
    ];

    environment.systemPackages = with pkgs; [
      wayland
      wireplumber
      cliphist

      xdg-desktop-portal-wlr
      xdg-desktop-portal
      xdg-desktop-portal-gtk
    ];

    services.xserver = {
      enable = true;
      xkb = {
        layout = "us";
        variant = "colemak_dh";
      };
    };

    programs.mango = {
      enable = true;
    };
    services.gnome.gnome-keyring.enable = true;

    # Mountable Drives
    services.devmon.enable = true;
    services.gvfs.enable = true;
    services.udisks2.enable = true;
  };

  flake.homeModules.mangowmModule =
    {
      self,
      inputs,
      pkgs,
      ...
    }:
    {
      imports = [
        inputs.mangowm.hmModules.mango

        self.homeModules.kittyModule
      ];

      home.file."/home/${userSettings.username}/platform_power_profile.sh" = {
        executable = true;
        text = ''
          FILE="/sys/firmware/acpi/platform_profile"

          inotifywait -m -e modify "$FILE" --format '%w%f' | while read FILE_CHANGED
          do
              PROFILE=$(cat "$FILE_CHANGED")

              case "$PROFILE" in
                  low-power)
                      MSG="Power Saver Mode"
                      ;;
                  balanced)
                      MSG="Balanced Mode"
                      ;;
                  performance)
                      MSG="Performance Mode"
                      ;;
                  *)
                      MSG="Unknown mode: $PROFILE"
                      ;;
              esac

              notify-send "Lenovo Fn+Q" "$MSG"
          done
        '';
      };

      home.packages = with pkgs; [
        brightnessctl
        playerctl

        grim
        slurp
        satty
        wayfreeze
      ];

      wayland.windowManager.mango = {
        enable = true;
        autostart_sh = ''
          bash /home/${userSettings.username}/platform_power_profile.sh &
          gammastep -O 7250 &

          # Keep clipboard content after app closes
          wl-clip-persist --clipboard regular --reconnect-tries 0 &
          # Watch clipboard and store history
          wl-paste --type text --watch cliphist store &
        '';

        settings = {
          # Input
          numlockon = 1;
          xkb_rules_layout = "us";
          xkb_rules_variant = "colemak_dh";

          trackpad_natural_scrolling = 1;

          mouse_accel_profile = 1;
          mouse_accel_speed = -0.1;

          # Scroller Settings
          scroller_structs = 12;
          scroller_default_proportion = 0.5;
          scroller_focus_center = 0;
          scroller_prefer_center = 0;
          scroller_proportion_preset = "0.33, 0.5, 0.67, 1.0";

          # Gestuures
          gesturebind = [
            "none,left,3,focusdir,left"
            "none,right,3,focusdir,right"
            "none,up,3,focusdir,up"
            "none,down,3,focusdir,down"

            "none, up, 4, viewtoright"
            "none, down, 4, viewtoleft"
          ];

          tagrule = [
            "id:*, layout_name:fair"
          ];

          mousebind = [
            "SUPER,btn_left,moveresize,curmove"
            "SUPER,btn_right,moveresize,curresize"
          ];

          bind = [
            "SUPER, RETURN, spawn, kitty"
            "SUPER, Q, killclient"
            "SUPER + SHIFT + CTRL, Q, quit"
            "SUPER, DELETE, quit"
            "SUPER, F5, reload_config"
            "SUPER, F11, togglefullscreen"
            "SUPER + SHIFT, F11, togglefakefullscreen"
            "SUPER, H, togglemaximizescreen"

            "SUPER, V, togglefloating"

            "SUPER, F1, spawn, bash '/home/${userSettings.username}/mangowm_powersave.sh'"
            "SUPER, F2, spawn, bash '/home/${userSettings.username}/mangowm_performance.sh'"

            "NONE,Print,spawn,bash /home/${userSettings.username}/.config/mango/scripts/freeze_screenshot.sh"
            "SUPER,Print,spawn,bash /home/${userSettings.username}/.config/mango/scripts/freeze_region_screenshot.sh"

            "SUPER, W, focusdir, up"
            "SUPER, S, focusdir, down"
            "SUPER, A, focusdir, left"
            "SUPER, D, focusdir, right"

            "SUPER + CTRL, W, resizewin, 0, +40"
            "SUPER + CTRL, S, resizewin, 0, -40"
            "SUPER + CTRL, A, resizewin, -40, 0"
            "SUPER + CTRL, D, resizewin, +40, 0"

            "SUPER, C, switch_proportion_preset"

            "SUPER + SHIFT, W, exchange_client, up"
            "SUPER + SHIFT, S, exchange_client, down"
            "SUPER + SHIFT, A, exchange_client, left"
            "SUPER + SHIFT, D, exchange_client, right"

            "SUPER + CTRL + SHIFT, A, scroller_stack, left"
            "SUPER + CTRL + SHIFT, D, scroller_stack, right"

            "SUPER, TAB, focusstack, next"
            "SUPER + SHIFT, TAB, focusstack, prev"

            "SUPER, 1, view, 1"
            "SUPER, 2, view, 2"
            "SUPER, 3, view, 3"
            "SUPER, 4, view, 4"
            "SUPER, 5, view, 5"
            "SUPER, E, view, 6"
            "SUPER, R, view, 7"

            "SUPER + SHIFT, 1, tag, 1"
            "SUPER + SHIFT, 2, tag, 2"
            "SUPER + SHIFT, 3, tag, 3"
            "SUPER + SHIFT, 4, tag, 4"
            "SUPER + SHIFT, 5, tag, 5"
            "SUPER + SHIFT, E, tag, 6"
            "SUPER + SHIFT, R, tag, 7"

            "SUPER + CTRL, 1, toggleview, 1"
            "SUPER + CTRL, 2, toggleview, 2"
            "SUPER + CTRL, 3, toggleview, 3"
            "SUPER + CTRL, 4, toggleview, 4"
            "SUPER + CTRL, 5, toggleview, 5"
            "SUPER + CTRL, E, toggleview, 6"
            "SUPER + CTRL, R, toggleview, 7"

            "SUPER, 9, setlayout, fair"
            "SUPER, 0, setlayout, scroller"

            "SUPER, LEFT, viewtoleft"
            "SUPER, RIGHT, viewtoright"

            # Brightness
            "NONE,XF86MonBrightnessUp,spawn,brightnessctl s +2%"
            "NONE,XF86MonBrightnessDown,spawn,brightnessctl s 2%-"

            # Volume
            "NONE,XF86AudioRaiseVolume,spawn,wpctl set-volume @DEFAULT_SINK@ 1%+"
            "NONE,XF86AudioLowerVolume,spawn,wpctl set-volume @DEFAULT_SINK@ 1%-"
            "NONE,XF86AudioMute,spawn,wpctl set-mute @DEFAULT_SINK@ toggle"
            "SHIFT,XF86AudioMute,spawn,wpctl set-mute @DEFAULT_SOURCE@ toggle"

            # Playback
            "NONE,XF86AudioNext,spawn,playerctl next"
            "NONE,XF86AudioPrev,spawn,playerctl previous"
            "NONE,XF86AudioPlay,spawn,playerctl play-pause"
          ];
        };
      };

      home.file."/home/${userSettings.username}/.config/mango/scripts/freeze_screenshot.sh" = {
        executable = true;
        text = ''
          #!/usr/bin/env bash
          pipe=$(mktemp -u).fifo
          mkfifo "$pipe"
          wayfreeze --after-freeze-timeout 100 --after-freeze-cmd "echo > $pipe" &
          wayfreeze_pid=$!
          read -r < "$pipe"
          grim "$HOME/Pictures/Screenshots/$(date +%Y%m%d%H%M%S).png"
          kill "$wayfreeze_pid" 2>/dev/null
          rm -f "$pipe"
        '';
      };
      home.file."/home/${userSettings.username}/.config/mango/scripts/freeze_region_screenshot.sh" = {
        executable = true;
        text = ''
          #!/usr/bin/env bash
          pipe=$(mktemp -u).fifo
          mkfifo "$pipe"
          wayfreeze --after-freeze-timeout 100 --after-freeze-cmd "echo > $pipe" &
          wayfreeze_pid=$!
          read -r < "$pipe"
          geometry=$(slurp -d)
          if [[ -z "$geometry" ]]; then
            kill "$wayfreeze_pid" 2>/dev/null
            rm -f "$pipe"
            exit 1
          fi
          grim -g "$geometry" "$HOME/Pictures/Screenshots/$(date +%Y%m%d%H%M%S).png"
          kill "$wayfreeze_pid" 2>/dev/null
          rm -f "$pipe"
        '';
      };

      home.file."/home/${userSettings.username}/mangowm_powersave.sh" = {
        executable = true;
        text = ''
          #!/usr/bin/env sh
          mmsg dispatch setoption, blur, 0
          mmsg dispatch setoption, shadows, 0
          mmsg dispatch setoption, border_radius, 0
          mmsg dispatch setoption, animations, 0

          notify-send "Mango" "Powersaving"
        '';
      };

      home.file."/home/${userSettings.username}/mangowm_performance.sh" = {
        executable = true;
        text = ''
          #!/usr/bin/env sh
          mmsg dispatch, reload_config
          notify-send "Mango" "Performance"
        '';
      };

      home.file."/home/${userSettings.username}/.config/xdg-desktop-portal/mango-portals.conf".text = ''
        [preferred]
        default=gtk
        org.freedesktop.impl.portal.ScreenCast=wlr
        org.freedesktop.impl.portal.Screenshot=wlr
        org.freedesktop.impl.portal.Secret=gnome-keyring
        org.freedesktop.impl.portal.Inhibit=none
      '';
    };
}
