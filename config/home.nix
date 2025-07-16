{ userSettings, ... }:
{
    imports = [
        ../packages/home.nix
    ];

    programs.home-manager.enable = true;

    home.username = userSettings.username;
    home.homeDirectory = "/home/${userSettings.username}";

    home.stateVersion = "25.05";

    programs.git = {
        enable = true;
        userName = userSettings.gitUserName;
        userEmail = userSettings.gitUserEmail;
    };
}