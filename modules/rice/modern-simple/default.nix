{ ... }:
{
  flake.nixosModules.modernSimpleRice = { inputs, pkgs, ... }: {
    fonts.packages = with pkgs; [
      maple-mono.NF

      inputs.san-francisco-fonts.packages.${pkgs.stdenv.hostPlatform.system}.sf-pro
    ];
  };

  flake.homeModules.modernSimpleRice = { self, inputs, pkgs, config, ... }: {
    imports = [
      inputs.noctalia.homeModules.default

      self.homeModules.modernSimpleHyprland
    ];

    gtk = {
      enable = true;
      colorScheme = "dark";
      font = {
        name = "SF Pro Display";
        package = inputs.san-francisco-fonts.packages.${pkgs.stdenv.hostPlatform.system}.sf-pro;
        size = 11;
      };
      iconTheme = {
        name = "Colloid-Dark";
        package = (
          pkgs.colloid-icon-theme.override {
            colorVariants = [ "default" ];
          }
        );
      };
    };

    programs.noctalia = {
      enable = true;
      settings = ./configs/noctalia.toml;
    };
  };
}
