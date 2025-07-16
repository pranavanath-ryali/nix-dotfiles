{ pkgs, systemSettings, ... }:
{
    environment.systemPackages = [ pkgs.wayland ];

    services.displayManager.gdm.enable = true;
    services.xserver = {
        enable = true;
        xkb = {
            layout = systemSettings.kbLayout;
            variant = systemSettings.kbVariant;
        };
    };
}