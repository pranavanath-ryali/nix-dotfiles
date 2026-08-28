{ ... }:
{
  flake.homeModules.gtkModernGlassRice =
    {
      pkgs,
      inputs,
      config,
      ...
    }:
    {
      gtk = {
        enable = true;
        colorScheme = "dark";
        font = {
          name = "SF Pro Display";
          package = inputs.apple-fonts.packages.${pkgs.stdenv.hostPlatform.system}.sf-pro;
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
        # theme = {
        #   # name = "Jasper-Grey-Dark-Compact";
        #   # package = (
        #   #   pkgs.jasper-gtk-theme.override {
        #   #     tweaks = [ "black" ];
        #   #     sizeVariants = [ "compact" ];
        #   #     themeVariants = [ "grey" ];
        #   #     colorVariants = [ "dark" ];
        #   #   }
        #   # );
        # };
        #
        # gtk4.theme = config.gtk.theme;
      };
    };
}
