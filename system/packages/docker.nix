{ userSettings, ... }:
{
    virtualisation.docker = {
        enable = true;
        rootless = {
            enable = true;
            setSocketVariable = true;
        };
    };
    users.users.${userSettings.username}.extraGroups = [ "docker" ];
}
