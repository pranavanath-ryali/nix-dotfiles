{ ... }:
{
  flake.nixosModules.poseidonBattery = { ... }: {
    powerManagement.enable = true;
    powerManagement.powertop.enable = false;

    services.upower.enable = true;
    services.tlp = {
      enable = true;

      settings = {
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";

        # Enable Runtime Power Management for PCI(e) devices on battery
        RUNTIME_PM_ON_AC = "on";
        RUNTIME_PM_ON_BAT = "auto";

        # Enable SATA & PCIe NVMe APST / ASPM low-power modes
        SATA_LINK_POWER_PER_BAT = "med_power_with_dipm";
        AHCI_RUNTIME_PM_ON_BAT = "auto";
        NVME_APST_COND_ON_BAT = "deep";

        PCIE_ASPM_ON_BAT = "powersave";

        WIFI_PWR_ON_BAT = "on";

        # Enable Audio Codec Powersave
        SOUND_POWER_SAVE_ON_BAT = 1;

        START_CHARGE_THRESH_BAT0 = 75;
        STOP_CHARGE_THRESH_BAT0 = 80;
      };
    };

    services.logind.settings.Login = {
      HandleLidSwitch = "suspend";
      HandleLidSwitchExternalPower = "ignore";
      HandleLidSwitchDocked = "ignore";
    };

    boot.kernelParams = [
      "mem_sleep_default=deep"
      "pcie_aspm=force"
    ];

    systemd.sleep.settings.Sleep = {
      HibernateDelaySec = "30m";
    };
  };
}
