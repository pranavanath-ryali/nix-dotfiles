{ userSettings, ... }:
{
  flake.nixosModules.systemConfiguration = { self, ... }: {
    imports = [
      self.nixosModules.defaultPackages
      self.nixosModules.direnv
      self.nixosModules.localsend
      self.nixosModules.flatpak
      self.nixosModules.steam

      self.nixosModules.hyprland
      self.nixosModules.modernSimpleRice
    ];

    nixpkgs.config.allowUnfree = true;
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    services.xserver = {
      enable = true;
      xkb = {
        layout = userSettings.xkb_layout;
        variant = userSettings.xkb_variant;
      };
    };

    time.timeZone = "Asia/Kolkata";
    i18n.defaultLocale = "en_US.UTF-8";
    i18n.extraLocaleSettings = {
      LC_ADDRESS = "en_IN";
      LC_IDENTIFICATION = "en_IN";
      LC_MEASUREMENT = "en_IN";
      LC_MONETARY = "en_IN";
      LC_NAME = "en_IN";
      LC_NUMERIC = "en_IN";
      LC_PAPER = "en_IN";
      LC_TELEPHONE = "en_IN";
      LC_TIME = "en_IN";
    };

    users.users.${userSettings.username} = {
      isNormalUser = true;
      description = userSettings.username;
      extraGroups = [
        "networkmanager"
        "wheel"
        "input"
      ];
    };

    system.stateVersion = "26.05";
  };
}
