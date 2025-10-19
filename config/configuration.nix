{ config, pkgs, systemSettings, userSettings, ... }:
{
    imports = [
        ../system/kernel/latest.nix

        ../system/drivers/bluetooth.nix
        ../system/drivers/pipewire.nix
        ../system/drivers/printing.nix
        ../system/drivers/graphics.nix

        ../packages/configuration.nix
        ../packages/system_packages/plymouth.nix

        (./. + "../../system/wm" + ("/" + userSettings.wm) + ".nix")
        (./. + "../../themes" + ("/" + userSettings.theme) + "/wm" + ("/" + userSettings.wm) + "/config.nix")
        (./. + "../../themes" + ("/" + userSettings.theme) + "/wm" + ("/" + userSettings.wm) + "/configuration.nix")
    ];

    boot.loader.systemd-boot.enable = true;
    boot.loader.systemd-boot.consoleMode = "max";
    boot.loader.efi.canTouchEfiVariables = true;

#     console.earlySetup = true;

    networking.hostName = systemSettings.hostname;

#     boot.kernelParams = ["resume_offset=25413632"];
#     boot.resumeDevice = "/dev/disk/by-uuid/ab6e5cb6-fbb9-4030-b199-8438982a5a8e";
#     powerManagement.enable = true;

    # Enable networking
    networking.networkmanager.enable = true;

    # Set your time zone.
    time.timeZone = systemSettings.timezone;

    # Select internationalisation properties.
    i18n.defaultLocale = systemSettings.locale;
    i18n.extraLocaleSettings = {
        LC_ADDRESS = systemSettings.locale;
        LC_IDENTIFICATION = systemSettings.locale;
        LC_MEASUREMENT = systemSettings.locale;
        LC_MONETARY = systemSettings.locale;
        LC_NAME = systemSettings.locale;
        LC_NUMERIC = systemSettings.locale;
        LC_PAPER = systemSettings.locale;
        LC_TELEPHONE = systemSettings.locale;
        LC_TIME = systemSettings.locale;
    };

    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    users.users.${userSettings.username} = {
        isNormalUser = true;
        description = userSettings.username;
        extraGroups = [ "networkmanager" "wheel" ];
        packages = with pkgs; [];
    };

    security.rtkit.enable = true;

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    system.stateVersion = "25.05";
}
