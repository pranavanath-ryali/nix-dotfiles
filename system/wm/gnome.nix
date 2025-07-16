{ pkgs, ... }:
{
    imports = [
        ./wayland.nix
    ];

    services.xserver.desktopManager.gnome.enable = true;

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