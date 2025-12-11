{ config, pkgs, ... }:
{
    programs.kitty = {
        enable = true;
        package = pkgs.kitty;

        enableGitIntegration = true;
        shellIntegration.enableFishIntegration = true;
    };
}
