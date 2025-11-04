{ inputs, pkgs, ... }:
{
    imports = [
        ./wayland.nix
        ./gnome-keyring.nix
    ];

    programs.hyprland = {
        enable = true;
        package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
        portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    };

    services.displayManager.gdm.enable = true;

    # Prelaod
    services.preload.enable = true;

    # Mountable Drives
    services.devmon.enable = true;
    services.gvfs.enable = true; 
    services.udisks2.enable = true;

    # Upower
    services.upower.enable = true;
    
    # Cachix for hyprland
    nix.settings = {
        substituters = ["https://hyprland.cachix.org"];
        trusted-substituters = ["https://hyprland.cachix.org"];
        trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
    };

    # Battery Saving
    services.tlp = {
        enable = true;
        settings = {
            CPU_SCALING_GOVERNOR_ON_BAT="powersave";
            CPU_SCALING_GOVERNOR_ON_AC="performance";

            CPU_MAX_PERF_ON_AC=95;
            CPU_MAX_PERF_ON_BAT=60;
        };
    };
}
