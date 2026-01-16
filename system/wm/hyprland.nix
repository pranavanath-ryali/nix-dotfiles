{ inputs, systemSettings, ... }:
{
    imports = [
        ./wayland.nix
    ];

    programs.hyprland = {
        enable = true;
        package = inputs.hyprland.packages.${systemSettings.system}.hyprland;
        portalPackage = inputs.hyprland.packages.${systemSettings.system}.xdg-desktop-portal-hyprland;
    };
}
