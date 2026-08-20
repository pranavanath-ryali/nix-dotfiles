{ userSettings, ... }:
{
  flake.nixosModules.hyprlandModule =
    {
      self,
      inputs,
      pkgs,
      ...
    }:
    {
      environment.systemPackages = with pkgs; [
        wayland
        wireplumber
      ];

      services.xserver = {
        enable = true;
        xkb = {
          layout = "us";
          variant = "colemak_dh";
        };
      };

      programs.hyprland = {
        enable = true;
        package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
        portalPackage =
          inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
      };

      services.gnome.gnome-keyring.enable = true;

      # Mountable Drives
      services.devmon.enable = true;
      services.gvfs.enable = true;
      services.udisks2.enable = true;
    };

  flake.homeModules.hyprlandModule =
    {
      inputs,
      pkgs,
      lib,
      ...
    }:
    {
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
        gammastep
        brightnessctl
        wireplumber

        hyprshot
      ];

      wayland.windowManager.hyprland = {
        enable = true;
        package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
        portalPackage =
          inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
        configType = "lua";

        extraConfig = ''
          -- monitor
          hl.monitor({
            output = "eDP-1",
            mode = "1920x1080@60",
            position = "0x0",
            scale = 1,
          })

          hl.bind("SUPER + Q", function() hl.dsp.window.close() end)
          hl.bind("SUPER + M", function() hl.dsp.layout("colresize 1.0") end)
          hl.bind("SUPER + V", function() hl.dsp.window.float() end)
          hl.bind("SUPER + F11", function() hl.dsp.window.fullscreen() end)
          hl.bind("SUPER + SHIFT + F11", function() hl.dsp.fullscreen_state(0, 2) end)
          hl.bind("SUPER + F1", function() hl.dsp.exec_cmd("bash /home/${userSettings.username}/hyprland_battery.sh") end)
          hl.bind("SUPER + SHIFT + PRINT", function() hl.dsp.exec_cmd("hyprshot -m region -o /home/${userSettings.username}/Pictures/Screenshots/") end)
          hl.bind("PRINT", function() hl.dsp.exec_cmd("hyprshot -m active -m output -o /home/${userSettings.username}/Pictures/Screenshots/") end)

          -- Workspace based binds
          hl.bind("SUPER + 1", function() hl.dsp.focus({ workspace = 1 }) end)
          hl.bind("SUPER + 2", function() hl.dsp.focus({ workspace = 2 }) end)
          hl.bind("SUPER + 3", function() hl.dsp.focus({ workspace = 3 }) end)
          hl.bind("SUPER + 4", function() hl.dsp.focus({ workspace = 4 }) end)
          hl.bind("SUPER + 5", function() hl.dsp.focus({ workspace = 5 }) end)
          hl.bind("SUPER + F", function() hl.dsp.focus({ workspace = 6 }) end)
          hl.bind("SUPER + P", function() hl.dsp.focus({ workspace = 7 }) end)
          hl.bind("SUPER + B", function() hl.dsp.focus({ workspace = 8 }) end)

          hl.bind("SUPER + CONTROL + SHIFT + 1", function() hl.dsp.window.move({ workspace = 1, focus = true }) end)
          hl.bind("SUPER + CONTROL + SHIFT + 2", function() hl.dsp.window.move({ workspace = 2, focus = true }) end)
          hl.bind("SUPER + CONTROL + SHIFT + 3", function() hl.dsp.window.move({ workspace = 3, focus = true }) end)
          hl.bind("SUPER + CONTROL + SHIFT + 4", function() hl.dsp.window.move({ workspace = 4, focus = true }) end)
          hl.bind("SUPER + CONTROL + SHIFT + 5", function() hl.dsp.window.move({ workspace = 5, focus = true }) end)
          hl.bind("SUPER + CONTROL + SHIFT + F", function() hl.dsp.window.move({ workspace = 6, focus = true }) end)
          hl.bind("SUPER + CONTROL + SHIFT + P", function() hl.dsp.window.move({ workspace = 7, focus = true }) end)
          hl.bind("SUPER + CONTROL + SHIFT + B", function() hl.dsp.window.move({ workspace = 8, focus = true }) end)

          hl.bind("SUPER + CONTROL + A", function() hl.dsp.layout("colresize -conf") end)
          hl.bind("SUPER + CONTROL + S", function() hl.dsp.layout("colresize +conf") end)

          hl.bind("SUPER + SHIFT + S", function() hl.dsp.window.move({ direction = "r" }) end)
          hl.bind("SUPER + SHIFT + A", function() hl.dsp.window.move({ direction = "l" }) end)
          hl.bind("SUPER + SHIFT + W", function() hl.dsp.window.move({ direction = "u" }) end)
          hl.bind("SUPER + SHIFT + R", function() hl.dsp.window.move({ direction = "d" }) end)

          hl.bind("SUPER + S", function() hl.dsp.layout("focus r") end)
          hl.bind("SUPER + A", function() hl.dsp.layout("focus l") end)
          hl.bind("SUPER + W", function() hl.dsp.layout("focus u") end)
          hl.bind("SUPER + R", function() hl.dsp.layout("focus d") end)

          hl.bind("SUPER + SHIFT + T", function() hl.dsp.layout("promote") end)

          hl.bind("SUPER + CONTROL + SHIFT + S", function() hl.dsp.layout("swapcol r") end)
          hl.bind("SUPER + CONTROL + SHIFT + A", function() hl.dsp.layout("swapcol l") end)

          hl.bind("SUPER + CONTROL + W", function() hl.dsp.window.resize({ x = 0, y = -30, relative = true }) end, { repeating = true })
          hl.bind("SUPER + CONTROL + R", function() hl.dsp.window.resize({ x = 0, y = 30, relative = true }) end, { repeating = true })
        '';

        settings = {
          # exec_cmd = [
          #   "bash /home/${userSettings.username}/platform_power_profile.sh"
          #   "gammastep -O 7250"
          # ];

          input = {
            kb_layout = "us";
            kb_variant = "colemak_dh";

            numlock_by_default = true;

            follow_mouse = 2;
            sensitivity = 0.2;
            accel_profile = "0.2144477506 0.000 0.307 0.615 1.077 1.539 2.002 2.505 3.208 3.910 4.613 5.315 6.018 6.720 7.423 8.125 8.828 9.530 10.233 10.935 12.387";

            touchpad = {
              natural_scroll = true;
            };
          };

          # Lua config expects device rules as a list/array of tables
          device = [
            {
              name = "instant-usb-gaming-mouse-";
              accel_profile = "flat";
              sensitivity = -0.2;
            }
          ];

          gestures = {
            workspace_swipe_distance = 600;
            workspace_swipe_min_speed_to_force = 30;
          };

          general =  {
            layout = "scrolling";
          };

          scrolling = {
            fullscreen_on_one_column = true;
            column_width = 0.5;
            explicit_column_widths = "0.25, 0.333, 0.5, 0.667, 0.75, 1.0";
          };

          # bindel = [
          #   ",XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%+"
          #   ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%-"
          #   ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
          #   ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
          # ];
          #
          # bindl = [
          #   ", XF86AudioNext, exec, playerctl next"
          #   ", XF86AudioPause, exec, playerctl play-pause"
          #   ", XF86AudioPlay, exec, playerctl play-pause"
          #   ", XF86AudioPrev, exec, playerctl previous"
          # ];
          #
          # bindm = [
          #   "SUPER, mouse:272, movewindow"
          #   "SUPER, mouse:273, resizewindow"
          # ];
        };
      };

      home.file."/home/pranavanath/hyprland_battery.sh" = {
        executable = true;
        text = ''
          #!/usr/bin/env sh
          HYPRGAMEMODE=$(hyprctl getoption animations:enabled | awk 'NR==1{print $2}')
          if [ "$HYPRGAMEMODE" = 1 ] ; then
              hyprctl --batch "\
                  keyword animations:enabled 0;\
                  keyword animation borderangle,0; \
                  keyword decoration:shadow:enabled 0;\
                  keyword decoration:blur:enabled 0;\
                  keyword decoration:fullscreen_opacity 1;\
                  keyword general:gaps_in 0;\
                  keyword general:gaps_out 0;\
                  keyword general:border_size 1;\
                  keyword decoration:rounding 0"
              notify-send "Hyprland" "Gamemode ON"
              exit
          else
              notify-send "Hyprland" "Gamemode OFF"
              hyprctl reload
              exit 0
          fi
          exit 1
        '';
      };
    };
}
