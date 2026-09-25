{
  inputs,
  self,
  globalSettings,
  userSettings,
  ...
}:
{
  flake.nixosConfigurations.poseidon = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    specialArgs = {
      inherit self;
      inherit inputs;
      pkgs-unstable = import inputs.nixpkgs-unstable {
        system = "x86_64-linux";
        config.allowUnfree = true;
      };
    };
    modules = [
      self.nixosModules.poseidonMachineModule

      self.nixosModules.poseidonGpuDriversModule
      self.nixosModules.poseidonBatteryOptimizations
      # self.nixosModules.poseidonDisplayModule

      self.nixosModules.bluetoothModule
      self.nixosModules.printingModule
      self.nixosModules.pipewireModule
    ];
  };

  flake.nixosModules.poseidonMachineModule =
    {
      inputs,
      pkgs,
      self,
      lib,
      ...
    }:
    {
      imports = [
        self.nixosModules.basePackages
        self.nixosModules.syncthingModule
      ]
      # Load wm
      ++ lib.optional (globalSettings.wm == "hyprland") self.nixosModules.hyprlandModule
      ++ lib.optional (globalSettings.wm == "mangowm") self.nixosModules.mangowmModule
      # Load rices
      ++ lib.optional (globalSettings.rice == "pitch-black") self.nixosModules.pitchBlackRice
      ++ lib.optional (globalSettings.rice == "modern-glass") self.nixosModules.modernGlassRice;

      networking.firewall = {
        enable = true;
        allowedTCPPorts = globalSettings.allowedTCPPorts;
        allowedUDPPortRanges = globalSettings.allowedUDPPortRanges;
      };

      nixpkgs.config.allowUnfree = true;

      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;

      networking.hostName = "poseidon";
      networking.networkmanager.enable = true;

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

      nix.settings.experimental-features = [
        "nix-command"
        "flakes"
      ];

      services.openssh = {
        enable = true;
        settings = {
          PasswordAuthentication = true;
          PermitRootLogin = "no";
        };
      };

      users.users.${userSettings.username} = {
        isNormalUser = true;
        description = "${userSettings.username}";
        extraGroups = [
          "networkmanager"
          "wheel"
        ];
      };

      services.usbmuxd.enable = true;

      # Recommended packages to interact with iOS devices
      environment.systemPackages = with pkgs; [
        libimobiledevice
        ifuse
      ];

      system.stateVersion = "25.11";
    };
}
