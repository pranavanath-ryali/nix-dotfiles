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

    # Mountable Drives
    services.devmon.enable = true;
    services.gvfs.enable = true; 
    services.udisks2.enable = true;

    # Upower
    services.upower.enable = true;
    
    boot.kernelParams = ["intel_pstate=disable"]; 
    services = {
        auto-cpufreq = {
            enable = true;
            settings = {
                battery = {
                    governor = "powersave";
                    turbo = "never";
                };
                charger = {
                    governor = "schedutil";
                    turbo = "auto";
                };
            };
        };

        system76-scheduler = {
            enable = true;
            useStockConfig = true;
        };
    };
}
