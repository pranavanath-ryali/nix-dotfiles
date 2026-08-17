{ ... }:
{
  flake.homeModules.waybarPitchBlackRiceModule = { config, ... }: {
      # ======================== WAYBAR CONFIG ========================
      config.dotfiles.waybar = {
        style = ''
          * {
            border: none;
            border-radius: 0;
            font-family: monospace;
            font-size: 12px;
            font-weight: bold;
            min-height: 0;

            margin: 0rem 0.1rem;
          }

          window#waybar {
            background: rgba(0, 0, 0, 1.0);
            color: white;
          }

          #battery, #clock, #memory, #cpu, #mpd, #cava {
            padding: 0 0.5rem;
          }
          #battery.charging {
            color: rgba(142, 111, 44, 1.0);
          }
        '';
        settings = {
          mainBar = {
            layer = "top";
            position = "top";
            height = 14;
            output = [
              "eDP-1"
            ];
            modules-left = [
              "mpd"
              "cava"
            ];
            modules-center = [
              "hyprland/workspaces"
            ];
            modules-right = [
              "cpu"
              "memory"
              "battery"
              "clock"
            ];

            "battery" = {
              interval = 15;
              states = {
                warning = 40;
                critical = 20;
              };
              format-icons = {
                default = [
                  "󰂎"
                  "󰁺"
                  "󰁻"
                  "󰁼"
                  "󰁽"
                  "󰁾"
                  "󰁿"
                  "󰂀"
                  "󰂁"
                  "󰂂"
                  "󰁹"
                ];
                charging = [
                  "󰢟"
                  "󰢜"
                  "󰂆"
                  "󰂇"
                  "󰂈"
                  "󰢝"
                  "󰂉"
                  "󰢞"
                  "󰂊"
                  "󰂋"
                  "󰂅"
                ];
              };
              format = "{icon} {capacity}% {power}W";
            };

            "mpd" = {
              format = "{stateIcon} {album} - {title}";
              format-disconnected = "Disconnected";
              format-stopped = "Stopped";

              album-len = 25;
              title-len = 35;

              state-icons = {
                playing = "";
                paused = "";
              };
            };

            "cava" = {
              "framerate" = 60;
              "autosens" = 1;
              "sensitivity" = 2;
              "bars" = 12;
              "lower_cutoff_freq" = 20;
              "higher_cutoff_freq" = 15000;
              "hide_on_silence" = true;
              # // "format_silent" = "quiet";
              "method" = "pulse";
              "source" = "auto";
              "stereo" = false;
              "reverse" = true;
              "bar_delimiter" = 0;
              "monstercat" = true;
              "waves" = true;
              "noise_reduction" = 0.2;
              "input_delay" = 2;
              "format-icons" = [
                "▁"
                "▂"
                "▃"
                "▄"
                "▅"
                "▆"
                "▇"
                "█"
              ];
              "actions" = {
                "on-click-right" = "mode";
              };
            };

            "hyprland/workspaces" = {
              "format" = "{icon}";
              "on-click" = "activate";
              "persistent-workspaces" = {
                "1" = [ ];
                "2" = [ ];
                "3" = [ ];
                "4" = [ ];
                "5" = [ ];
                "6" = [ ];
                "7" = [ ];
                "8" = [ ];
                "9" = [ ];
              };
              "format-icons" = {
                "urgent" = "";
                "active" = "";
                "default" = "";
              };
              "sort-by-number" = true;
            };

            "cpu" = {
              interval = 5;
              format = "  {usage}%";
            };

            "memory" = {
              interval = 15;
              format = "  {percentage}% {swapPercentage}%";
            };

            "clock" = {
              format = "{:%H:%M}";
              format-alt = "{:%A, %B %d, %Y (%R)}  ";
              tooltip-format = "<tt><small>{calendar}</small></tt>";
              calendar = {
                mode = "year";
                mode-mon-col = 3;
                weeks-pos = "right";
                on-scroll = 1;
                format = {
                  "months" = "<span color='#ffead3'><b>{}</b></span>";
                  "days" = "<span color='#ecc6d9'><b>{}</b></span>";
                  "weeks" = "<span color='#99ffdd'><b>W{}</b></span>";
                  "weekdays" = "<span color='#ffcc66'><b>{}</b></span>";
                  "today" = "<span color='#ff6699'><b><u>{}</u></b></span>";
                };
              };
              actions = {
                on-click-right = "mode";
                on-scroll-up = "tz_up";
                on-scroll-down = "tz_down";
                # on-scroll-up= "shift_up";
                # on-scroll-down= "shift_down";
              };
            };
          };
        };
      };
  };
}
