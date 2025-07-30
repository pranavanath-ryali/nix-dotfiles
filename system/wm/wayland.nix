{ pkgs, systemSettings, ... }:
{
    environment.systemPackages = [ pkgs.wayland ];

    services.xserver = {
        enable = true;
        xkb = {
            layout = systemSettings.kbLayout;
            variant = systemSettings.kbVariant;
        };
    };
}
