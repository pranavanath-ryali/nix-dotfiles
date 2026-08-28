{ ... }:
{
  flake.homeModules.mangowmModernGlassRice = { self, pkgs, ... }: {
    imports = [
      self.homeModules.kittyModule
      self.homeModules.fishModule
      self.homeModules.vicinaeModule
    ];

    home.packages = with pkgs; [
      nautilus
      file-roller
      zathura
    ];

    # ==================[ MANGOWM ]==================
    wayland.windowManager.mango = {
      autostart_sh = ''
        noctalia --daemon &
      '';

      settings = {
        source-optional = [
          "~/.config/mango/noctalia.conf"
        ];

        borderpx = 2;
        gappih = 12;
        gappiv = 12;
        gappoh = 16;
        gappov = 16;

        border_radius = 16;
        focused_opacity = 1.0;
        unfocused_opacity = 0.8;

        blur = 1;
        blur_layer = 1;
        blur_optimized = 1;
        blur_params_radius = 6;
        blur_params_num_passes = 3;
        blur_params_noise = 0.04;
        blur_params_brightness = 1;
        blur_params_contrast = 0.9;
        blur_params_saturation = 1.2;

        shadows = 1;
        layer_shadows = 0;
        shadow_only_floating = 0;
        shadows_size = 4;
        shadows_blur = 12;
        shadows_position_x = 2;
        shadows_position_y = 2;
        shadowscolor = "0x000000ff";

        tag_animation_direction = 0;
        animation_type_open = "slide";
        animation_type_close = "zoom";
        layer_animation_type_open = "slide";
        layer_animation_type_close = "slide";

        animation_duration_open = 300;
        animation_duration_close = 400;
        animation_duration_move = 500;
        animation_duration_tag = 400;

        bind = [
          "SUPER, K, spawn, nautilus"
          "SUPER + ALT, W, spawn, noctalia msg panel-toggle wallpaper"
          "SUPER, SPACE, spawn, vicinae toggle"
        ];
      };
    };
  };
}
