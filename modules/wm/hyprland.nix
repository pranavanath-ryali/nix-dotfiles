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

      # services.displayManager.sddm = {
      #   enable = true;
      #   wayland.enable = true;
      # };
      # services.displayManager.gdm.enable = true;
      services.gnome.gnome-keyring.enable = true;

      # Mountable Drives
      services.devmon.enable = true;
      services.gvfs.enable = true;
      services.udisks2.enable = true;
    };

  flake.homeModules.hyprlandModule =
    {
      self,
      inputs,
      pkgs,
      config,
      lib,
      # userSettings,
      ...
    }:
    let
      inherit (lib) mkOption types;
    in
    {
      # Provide attributes to theme hyprland
      options.dotfiles.hyprland = mkOption {
        type = types.submodule {
          options = {
            exec-once = mkOption {
              type = types.listOf types.str;
              default = [ ];
            };
            bezier = mkOption {
              type = types.listOf types.str;
              default = [ ];
            };
            animation = mkOption {
              type = types.listOf types.str;
              default = [
                "workspaces, 1, 5, default, slidevert"
              ];
            };

            general = mkOption {
              default = { };
              type = types.submodule {
                options = {
                  border_size = mkOption {
                    type = types.int;
                    default = 1;
                  };
                  gaps_in = mkOption {
                    type = types.int;
                    default = 1;
                  };
                  gaps_out = mkOption {
                    type = types.int;
                    default = 1;
                  };
                };
              };
            };

            color = mkOption {
              default = { };
              type = types.submodule {
                options = {
                  inactive_border = mkOption {
                    type = types.str;
                    default = "0xff858585";
                  };
                  active_border = mkOption {
                    type = types.str;
                    default = "0xffffffff";
                  };
                  shadow_active = mkOption {
                    type = types.str;
                    default = "0xee1a1a1a";
                  };
                  shadow_inactive = mkOption {
                    type = types.str;
                    default = "0xee1a1a1a";
                  };
                };
              };
            };

            decoration = mkOption {
              default = { };
              type = types.submodule {
                options = {
                  rounding = mkOption {
                    type = types.int;
                    default = 8;
                  };
                  rounding_power = mkOption {
                    type = types.float;
                    default = 2.0;
                  };

                  active_opacity = mkOption {
                    type = types.float;
                    default = 1.0;
                  };
                  inactive_opacity = mkOption {
                    type = types.float;
                    default = 1.0;
                  };
                  fullscreen_opacity = mkOption {
                    type = types.float;
                    default = 1.0;
                  };

                  dim_inactive = mkOption {
                    type = types.bool;
                    default = false;
                  };
                  dim_strength = mkOption {
                    type = types.float;
                    default = 0.0;
                  };

                  blur = mkOption {
                    default = { };
                    type = types.submodule {
                      options = {
                        enabled = mkOption {
                          type = types.bool;
                          default = true;
                        };
                        size = mkOption {
                          type = types.int;
                          default = 8;
                        };
                        passes = mkOption {
                          type = types.int;
                          default = 1;
                        };
                        noise = mkOption {
                          type = types.float;
                          default = 0.0117;
                        };
                        contrast = mkOption {
                          type = types.float;
                          default = 0.8916;
                        };
                        vibrancy = mkOption {
                          type = types.float;
                          default = 0.1696;
                        };
                        vibrancy_darkness = mkOption {
                          type = types.float;
                          default = 0.0;
                        };
                      };
                    };
                  };

                  shadow = mkOption {
                    default = { };
                    type = types.submodule {
                      options = {
                        enabled = mkOption {
                          type = types.bool;
                          default = true;
                        };
                        range = mkOption {
                          type = types.int;
                          default = 4;
                        };
                        render_power = mkOption {
                          type = types.int;
                          default = 3;
                        };
                        sharp = mkOption {
                          type = types.bool;
                          default = false;
                        };
                        offset = mkOption {
                          type = types.str;
                          default = "0 0";
                        };
                        scale = mkOption {
                          type = types.float;
                          default = 1.0;
                        };
                      };
                    };
                  };
                };
              };
            };

            bind = mkOption {
              default = [ ];
              type = types.listOf types.str;
            };
            bindel = mkOption {
              default = [ ];
              type = types.listOf types.str;
            };
          };
        };
        default = { };
      };
      config = {
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
          configType = "hyprlang";
          settings = {
            monitor = [
              "eDP-1,preferred,0x0,1.0"
            ];

            exec-once = [
              "bash /home/${userSettings.username}/platform_power_profile.sh"
              "gammastep -O 7250"
            ]
            ++ config.dotfiles.hyprland.exec-once;

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

            device = {
              name = "instant-usb-gaming-mouse-";
              accel_profile = "flat";
              sensitivity = -0.2;
            };

            gestures = {
              workspace_swipe_distance = 600;
              workspace_swipe_min_speed_to_force = 30;
            };

            gesture = [
              # Scroll how much force and distance needed to swipe gesture
              "3, vertical, workspace"
            ];

            general = lib.recursiveUpdate {
              layout = "scrolling";

              "col.inactive_border" = config.dotfiles.hyprland.color.inactive_border;
              "col.active_border" = config.dotfiles.hyprland.color.active_border;
            } config.dotfiles.hyprland.general;

            scrolling = {
              fullscreen_on_one_column = true;
              column_width = 0.5;
              explicit_column_widths = "0.25, 0.333, 0.5, 0.667, 0.75, 1.0";
            };

            bezier = config.dotfiles.hyprland.bezier;
            animation = config.dotfiles.hyprland.animation;
            decoration = lib.recursiveUpdate {
              shadow.color = config.dotfiles.hyprland.color.shadow_active;
              shadow.color_inactive = config.dotfiles.hyprland.color.shadow_inactive;
            } config.dotfiles.hyprland.decoration;

            "$mainMod" = "SUPER";
            bind = [
              # General Bindings
              "$mainMod, Q, killactive,"
              "$mainMod, M, layoutmsg, colresize 1.0"
              "$mainMod, V, togglefloating,"
              "$mainMod SHIFT, DELETE, exit"
              "$mainMod, F11, fullscreen,"
              "$mainMod SHIFT, F11, fullscreenstate, 0 2"

              "$mainMod, F1, exec, bash /home/${userSettings.username}/hyprland_battery.sh"

              # TODO: Screenshots
              "$mainMod SHIFT, PRINT, exec, hyprshot -m region -o /home/${userSettings.username}/Pictures/Screenshots/" # TODO: Declare a global username variable
              ", PRINT, exec, hyprshot -m active -m output -o /home/${userSettings.username}/Pictures/Screenshots/"

              "$mainMod, 1, workspace, 1"
              "$mainMod, 2, workspace, 2"
              "$mainMod, 3, workspace, 3"
              "$mainMod, 4, workspace, 4"
              "$mainMod, 5, workspace, 5"
              "$mainMod, F, workspace, 6"
              "$mainMod, P, workspace, 7"

              "$mainMod CONTROL, A, layoutmsg, colresize -conf"
              "$mainMod CONTROL, S, layoutmsg, colresize +conf"

              "$mainMod SHIFT, S, movewindow, r"
              "$mainMod SHIFT, A, movewindow, l"
              "$mainMod SHIFT, W, movewindow, u"
              "$mainMod SHIFT, R, movewindow, d"

              "$mainMod SHIFT, T, layoutmsg, promote"

              "$mainMod CONTROL SHIFT, S, layoutmsg, swapcol r"
              "$mainMod CONTROL SHIFT, A, layoutmsg, swapcol l"

              "$mainMod CONTROL SHIFT, 1, movetoworkspace, 1"
              "$mainMod CONTROL SHIFT, 2, movetoworkspace, 2"
              "$mainMod CONTROL SHIFT, 3, movetoworkspace, 3"
              "$mainMod CONTROL SHIFT, 4, movetoworkspace, 4"
              "$mainMod CONTROL SHIFT, 5, movetoworkspace, 5"
              "$mainMod CONTROL SHIFT, F, movetoworkspace, 6"
              "$mainMod CONTROL SHIFT, P, movetoworkspace, 7"

              "$mainMod, S, layoutmsg, focus r"
              "$mainMod, A, layoutmsg, focus l"
              "$mainMod, W, layoutmsg, focus u"
              "$mainMod, R, layoutmsg, focus d"

              "$mainMod, mouse_down, workspace, e-1"
              "$mainMod, mouse_up, workspace, e-1"
            ]
            ++ config.dotfiles.hyprland.bind;

            binde = [
              "$mainMod CONTROL, W, resizeactive, 0 -30"
              "$mainMod CONTROL, R, resizeactive, 0 30"
            ];

            bindel = [
              ",XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%+"
              ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%-"
              ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
              ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
              # ",XF86MonBrightnessUp, exec, brightnessctl s 5%+"
              # ",XF86MonBrightnessDown, exec, brightnessctl s 5%-"
            ]
            ++ config.dotfiles.hyprland.bindel;

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

    };
}
