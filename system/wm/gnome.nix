{ pkgs, ... }:
{
    imports = [
        ./wayland.nix
    ];

    services.desktopManager.gnome.enable = true;
    services.displayManager.gdm.enable = true;

    environment.gnome.excludePackages = with pkgs; [
        orca
        evince
        geary
        gnome-tour
        gnome-user-docs
        baobab
        epiphany
        gnome-contacts
        gnome-logs
        gnome-maps
        gnome-music
        gnome-connections
        simple-scan
        yelp
        gnome-software
    ];
}
