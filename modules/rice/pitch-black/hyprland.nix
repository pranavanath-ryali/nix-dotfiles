{ ... }:
{
  flake.homeModules.hyprlandPitchBlackRiceModule =
    {
      self,
      pkgs,
      ...
    }:
    {
      imports = [
        self.homeModules.kittyModule
        self.homeModules.fishModule
        self.homeModules.vicinaeModule
        self.homeModules.awwwModule
        self.homeModules.dunstModule
        self.homeModules.waybarModule
        self.homeModules.hyprlockModule
      ];

      # ======================== COMMON APPLICATIONS ========================
      home.packages = with pkgs; [
        nautilus
        file-roller
        euphonica
        zathura

        brightnessctl
      ];

      # ======================== HYPRLOCK ========================
      # config.dotfiles.hyprlock.settings = {
      #   background = [
      #     {
      #       monitor = "";
      #       color = "rgb(000000)"; # Pure black background
      #     }
      #   ];
      #
      #   input-field = [
      #     {
      #       monitor = "";
      #       size = "800, 100";
      #       outline_thickness = 0;
      #
      #       # Dot configuration to look like standard asterisks
      #       dots_size = 0.4;
      #       dots_spacing = 0.5;
      #       dots_center = true;
      #       dots_rounding = -1;
      #
      #       # Hide the input box container entirely
      #       fade_on_empty = false;
      #       inner_color = "rgba(0, 0, 0, 0)";
      #       outer_color = "rgba(0, 0, 0, 0)";
      #       font_color = "rgb(255, 255, 255)";
      #
      #       # The blinking cursor modification
      #       placeholder_text = "<span foreground=\"##ffffff\">|</span>";
      #
      #       # Center the input field on the screen
      #       position = "0, 0";
      #       halign = "center";
      #       valign = "center";
      #     }
      #   ];
      # };
      #
      # # ======================== HYPRIDLE ========================
      # config = {
      #   services.hypridle = {
      #     enable = true;
      #
      #     settings = {
      #       general = {
      #         lock_cmd = "pidof hyprlock || hyprlock"; # avoids starting multiple hyprlock instances
      #         unlock_cmd = "killall -q hyprlock"; # unlocks when receiving an unlock event
      #         before_sleep_cmd = "loginctl lock-session"; # lock screen before the system goes to sleep
      #         after_sleep_cmd = "hyprctl dispatch dpms on"; # avoids having to press a key twice to wake the display
      #         ignore_dbus_inhibit = false; # respect Firefox/Steam inhibitors
      #         ignore_wayland_inhibit = false;
      #         ignore_systemd_inhibit = false;
      #       };
      #
      #       listener = [
      #         # 1. Dim the monitor backlight (after 2.5 minutes)
      #         {
      #           timeout = 150;
      #           on-timeout = "brightnessctl -s set 10";
      #           on-resume = "brightnessctl -r";
      #         }
      #         # 2. Turn off keyboard backlight (after 2.5 minutes)
      #         {
      #           timeout = 150;
      #           on-timeout = "brightnessctl -sd rgb:kbd_backlight set 0";
      #           on-resume = "brightnessctl -rd rgb:kbd_backlight";
      #         }
      #         # 3. Lock the screen (after 5 minutes)
      #         {
      #           timeout = 300;
      #           on-timeout = "loginctl lock-session";
      #         }
      #         # 4. Turn off screen via DPMS (after 5.5 minutes)
      #         {
      #           timeout = 330;
      #           on-timeout = "hyprctl dispatch dpms off";
      #           on-resume = "hyprctl dispatch dpms on";
      #         }
      #         # 5. Suspend PC (after 30 minutes)
      #         {
      #           timeout = 1800;
      #           on-timeout = "systemctl suspend";
      #         }
      #       ];
      #     };
      #   };
      # };

      # ======================== HYPRLAND ========================
      wayland.windowManager.hyprland.settings = {
      };


    #   config.dotfiles.hyprland = {
    #     exec-once = [
    #       "waybar"
    #       "awww-daemon"
    #     ];
    #
    #     bezier = [
    #       "linear, 0, 0, 1, 1"
    #       "md3_standard, 0.2, 0, 0, 1"
    #       "md3_decel, 0.05, 0.7, 0.1, 1"
    #       "md3_accel, 0.3, 0, 0.8, 0.15"
    #       "overshot, 0.05, 0.9, 0.1, 1.1"
    #       "crazyshot, 0.1, 1.5, 0.76, 0.92 "
    #       "hyprnostretch, 0.05, 0.9, 0.1, 1.0"
    #       "menu_decel, 0.1, 1, 0, 1"
    #       "menu_accel, 0.38, 0.04, 1, 0.07"
    #       "easeInOutCirc, 0.85, 0, 0.15, 1"
    #       "easeOutCirc, 0, 0.55, 0.45, 1"
    #       "easeOutExpo, 0.16, 1, 0.3, 1"
    #       "softAcDecel, 0.26, 0.26, 0.15, 1"
    #       "md2, 0.4, 0, 0.2, 1"
    #     ];
    #
    #     animation = [
    #       "windows, 1, 3, md3_decel, popin 60%"
    #       "windowsIn, 1, 3, md3_decel, popin 60%"
    #       "windowsOut, 1, 3, md3_accel, popin 60%"
    #       "border, 1, 10, default"
    #       "fade, 1, 3, md3_decel"
    #       "layersIn, 1, 3, menu_decel, slide"
    #       "layersOut, 1, 1.6, menu_accel"
    #       "fadeLayersIn, 1, 2, menu_decel"
    #       "fadeLayersOut, 1, 4.5, menu_accel"
    #       "workspaces, 1, 7, menu_decel, slidefadevert 15%"
    #       # "workspaces, 1, 7, menu_decel, slidevert"
    #       # "workspaces, 1, 2.5, softAcDecel, slidevert"
    #       # "layers, 1, 2, md3_decel, slide"
    #       # "specialWorkspace, 1, 3, md3_decel, slidefadevert 15%"
    #     ];
    #
    #     general = {
    #       border_size = 4;
    #       gaps_in = 8;
    #       gaps_out = 18;
    #     };
    #
    #     decoration = {
    #       rounding = 0;
    #
    #       dim_inactive = true;
    #       dim_strength = 0.125;
    #
    #       blur.enabled = false;
    #
    #       shadow = {
    #         enabled = true;
    #         range = 12;
    #         render_power = 4;
    #
    #         offset = "6 6";
    #         scale = 1.0;
    #       };
    #     };
    #
    #     color = {
    #       inactive_border = "0xff8f8f8f";
    #       active_border = "0xffffffff";
    #
    #       shadow_active = "rgba(505050ff)";
    #       shadow_inactive = "rgba(505050ff)";
    #     };
    #
    #     bind = [
    #       "$mainMod, E, exec, nautilus"
    #       "$mainMod, RETURN, exec, kitty"
    #
    #       "$mainMod, SPACE, exec, vicinae toggle"
    #     ];
    #     bindel = [
    #       ",XF86MonBrightnessUp, exec, brightnessctl s 1%+"
    #       ",XF86MonBrightnessDown, exec, brightnessctl s 1%-"
    #     ];
    #   };
    };
}
