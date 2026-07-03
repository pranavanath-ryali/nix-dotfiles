{ ... }:
{
  flake.homeModules.gtkPitchBlackRiceModule =
    { pkgs, ... }:
    {
      gtk = {
        enable = true;
        colorScheme = "dark";
        font = {
          name = "MartianMono NF";
          package = pkgs.nerd-fonts.martian-mono;
          size = 8;
        };
        iconTheme = {
          name = "Colloid-Grey-Dark";
          package = (
            pkgs.colloid-icon-theme.override {
              colorVariants = [ "grey" ];
            }
          );
        };
        theme = {
          name = "Jasper-Grey-Dark-Compact";
          package = (
            pkgs.jasper-gtk-theme.override {
              tweaks = [ "black" ];
              sizeVariants = [ "compact" ];
              themeVariants = [ "grey" ];
              colorVariants = [ "dark" ];
            }
          );
        };
      };
    };
}
