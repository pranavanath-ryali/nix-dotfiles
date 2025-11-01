{ userSettings, ... }:
{
    imports = [
        ../packages/packages.nix

        (./. + "../../home/wm" + ("/" + userSettings.wm) + ".nix")
        (./. + "../../themes" + ("/" + userSettings.theme) + "/wm" + ("/" + userSettings.wm) + "/config.nix")
        (./. + "../../themes" + ("/" + userSettings.theme) + "/wm" + ("/" + userSettings.wm) + "/home.nix")
    ];

    programs.home-manager.enable = true;

    home.username = userSettings.username;
    home.homeDirectory = "/home/${userSettings.username}";
    
    xdg.mimeApps = {
        enable = true;
    };

    programs.git = {
        enable = true;
    };

    home.stateVersion = "25.05";
}
