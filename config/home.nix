{ userSettings, ... }:
{
    imports = [
        ../home/packages.nix
        ../home/shell/fish.nix

        (./. + "./../home/wm" + ("/" + userSettings.wm) + ".nix")
        (./. + "./../rices" + ("/" + userSettings.theme) + "/wm" + ("/" + userSettings.wm) + "/config.nix")
        (./. + "./../rices" + ("/" + userSettings.theme) + "/wm" + ("/" + userSettings.wm) + "/home.nix")
    ];

    programs.home-manager.enable = true;

    home.username = userSettings.username;
    home.homeDirectory = "/home/${userSettings.username}";

    fonts.fontconfig.enable = true;
    
    xdg.mimeApps = {
        enable = true;
    };

    programs.git = {
        enable = true;
    };

    home.file."Pictures/wallpapers".source = ../wallpapers;

    home.stateVersion = "25.05";
}
