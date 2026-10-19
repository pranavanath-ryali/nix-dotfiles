{ inputs, self, userSettings, ... }:
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
      self.nixosModules.bluetooth
      self.nixosModules.pipewire
      self.nixosModules.poseidonHost
      self.nixosModules.poseidonHardwareConfig
      self.nixosModules.poseidonGraphics
      self.nixosModules.poseidonBattery
    ];
  };

  flake.nixosModules.poseidonHost = { self, pkgs, ... }: {
    imports = [
      self.nixosModules.systemConfiguration
    ];

    networking.hostName = "poseidon";

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.kernelPackages = pkgs.linuxPackages_latest;

    networking.networkmanager.enable = true;
  };
}
