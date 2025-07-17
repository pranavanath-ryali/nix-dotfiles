{ inputs, systemSettings, ... }:
{
    home.packages = [
        inputs.quickshell.packages.${systemSettings.system}.default
    ];
}