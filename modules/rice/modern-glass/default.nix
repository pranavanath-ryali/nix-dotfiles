{ globalSettings, ... }:
{
  flake.nixosModules.modernGlassRice = { inputs, pkgs, ... }: {
    fonts.packages = [
      inputs.apple-fonts.packages.${pkgs.stdenv.hostPlatform.system}.sf-pro
      inputs.apple-fonts.packages.${pkgs.stdenv.hostPlatform.system}.sf-compact
      inputs.apple-fonts.packages.${pkgs.stdenv.hostPlatform.system}.sf-mono-nerd

      pkgs.nerd-fonts.martian-mono
    ];
  };

  flake.homeModules.modernGlassRice =
    {
      self,
      lib,
      inputs,
      ...
    }:
    {
      imports = [
        inputs.noctalia.homeModules.default
        
        self.homeModules.gtkModernGlassRice
      ]
      ++ lib.optional (globalSettings.wm == "mangowm") self.homeModules.mangowmModernGlassRice;

      # ==================[ NOCTALIA ]==================
      programs.noctalia = {
        enable = true;
      };

      # ==================[ KITTY ]==================
      programs.kitty = {
        extraConfig = ''
          include themes/noctalia.conf

          background_opacity 0.7

          font_family family="SFMono Nerd Font"
          font_size 11

          window_padding_width 8 8 8 8
        '';
      };

      # ==================[ KITTY ]==================
      programs.vicinae.settings = {
        font = {
          normal = {
            family = "SF Pro Display";
            size = 10.5;
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
          opacity = 0.55;
          rouding = 16;

          compact_mode.enabled = true;

          size = {
            width = 600;
            height = 370;
          };
        };
      };
    };
}
