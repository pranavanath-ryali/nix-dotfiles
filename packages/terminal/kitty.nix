{ config, pkgs, ... }:
{
    programs.kitty = {
        enable = true;
        package = pkgs.kitty;
        # settings = config.theme_kitty_settings;

        shellIntegration.enableFishIntegration = true;
    };
}
