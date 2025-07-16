{ userSettings, ... }:
{
    programs.home-manager.enable = true;

    home.username = ${userSettings.username};
    home.homeDirectory = "/home/${userSettings.username}";

    home.stateVersion = "25.05";
}