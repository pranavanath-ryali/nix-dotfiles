{ inputs, systemSettings, ... }:
{
    wayland.windowManager.hyprland = {
        enable = true;
        package = inputs.hyprland.packages.${systemSettings.system}.hyprland;
        portalPackage = inputs.hyprland.packages.${systemSettings.system}.xdg-desktop-portal-hyprland;

        settings = {
            "$mod" = "SUPER";

            bind = [

            ];
        };
    };
}
