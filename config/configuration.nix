{ config, pkgs, systemSettings, userSettings, ... }:
{
    imports = [
        ../system/kernel/latest.nix

        ../system/drivers/bluetooth.nix
        ../system/drivers/pipewire.nix
        ../system/drivers/printing.nix

        (./. + "../system/wm/" + userSettings.wm ".nix")
    ];

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    networking.hostName = systemSettings.hostname;

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

    # Install firefox.
    programs.firefox.enable = true;

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    # List packages installed in system profile. To search, run:
    # $ nix search wget
    environment.systemPackages = with pkgs; [
    #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    #  wget
        neovim
        git
        gh
        vscode
        obsidian
    ];

    system.stateVersion = "25.05";
}
