{ userSettings, ... }:
{
  flake.homeModules.modernSimpleHyprland = { self, ... }: {
    imports = [
      self.homeModules.alacritty
      self.homeModules.vicinae
    ];

    programs.alacritty.settings = {
      general = {
        import = [
          "~/.config/alacritty/themes/noctalia.toml"
        ];
      };

      font = {
        normal = {
          family = "Maple Mono NF";
        };
        bold = {
          family = "Maple Mono NF";
        };
        italic = {
          family = "Maple Mono NF";
        };
        bold_italic= {
          family = "Maple Mono NF";
        };

        size = 11;
      };

      window = {
        padding = {
          x = 16;
          y = 16;
        };
        opacity = 0.6;
      };
    };

    programs.vicinae.settings = {
      favicon_service = "twenty";

      font = {
        normal = {
          family = "Maple Mono NF";
          size = 10;
        };
      };

      theme = {
        light = {
          name = "noctalia";
          icon_theme = "auto";
        };
        dark = {
          name = "noctalia";
          icon_theme = "auto";
        };
      };

      launcher_window = {
        opacity = 0.6;
        rouding = 16;

        compact_mode.enabled = true;

        size = {
          width = 600;
          height = 370;
        };
      };
    };

    home.file."/home/${userSettings.username}/.config/hypr/rice/modern_simple.lua".text = ''
local noctalia = require("../noctalia")

hl.on("hyprland.start", function()
  hl.exec_cmd("noctalia")
  hl.exec_cmd("vicinae server")
end)

hl.config({
  general = {
    border_size = 2,

    gaps_out = 8,
    gaps_in = 6,
  },
  decoration = {
    inactive_opacity = 0.9,

    rounding = 16,

    blur = {
      enabled = true,
      noise = 0.1,
      brightness = 0.7,
      contrast = 1.7,

      passes = 3,
      size = 12,
    },

    shadow = {
      enabled = true,
      color = noctalia.colors.surface,
      offset = { 0, 0 },
      range = 6,
      render_power = 3,
    },
  }
})
noctalia.apply_theme()

hl.bind("SUPER + RETURN", hl.dsp.exec_cmd("alacritty"))
hl.bind("SUPER + SPACE", hl.dsp.exec_cmd("vicinae toggle"))
    '';
  };
}
