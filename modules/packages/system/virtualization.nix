{ userSettings, ... }:
{
  flake.nixosModules.virtualizationModule =
    {
      pkgs,
      pkgs-2511,
      inputs,
      ...
    }:
    {
      imports = [
        inputs.i915-sriov.nixosModules.default
      ];

      programs.virt-manager.enable = true;

      users.groups.libvirtd.members = [ "${userSettings.username}" ];
      users.groups.kvm.members = [ "${userSettings.username}" ];

      virtualisation = {
        libvirtd.enable = true;
        libvirtd.qemu = {
          swtpm.enable = true;
          vhostUserPackages = [ pkgs.virtiofsd ];
        };
        spiceUSBRedirection.enable = true;
      };

      environment.systemPackages = with pkgs; [
        qemu
        dnsmasq
        phodav

        virt-viewer
        looking-glass-client
      ];

      # Linux kernel
      # boot.kernelPackages = pkgs.linux;
      boot.kernelParams = [
        "intel_iommu=on"
        "iommu=pt"
      ];

      specialisation = {
        sriov.configuration = {
          # Add SR-IOV related kernel modules
          boot.kernelModules = [
            "vfio"
            "vfio_iommu_type1"
            "vfio_pci"
          ];

          boot.extraModprobeConfig = ''
            options vfio-pci ids=
          '';

          boot.extraModulePackages = [ pkgs.i915-sriov ];

          # Example: enable IOMMU + SR-IOV related params
          boot.kernelParams = [
            "intel_iommu=on"
            "iommu=pt"

            "i915.enable_guc=3"
            "i915.max_vfs=1"
            "module_blacklist=xe"
          ];

          services.udev.extraRules = ''
            # Bind all i915 VFs (00:02.1 to 00:02.7) to vfio-pci, leave PF (00:02.0) alone
            ACTION=="add", SUBSYSTEM=="pci", KERNEL=="0000:00:02.[1-7]", ATTR{vendor}=="0x8086", ATTR{device}=="0x46a8", DRIVER!="vfio-pci", RUN+="${pkgs.bash}/bin/sh -c 'echo $kernel > /sys/bus/pci/devices/$kernel/driver/unbind; echo vfio-pci > /sys/bus/pci/devices/$kernel/driver_override; modprobe vfio-pci; echo $kernel > /sys/bus/pci/drivers/vfio-pci/bind'"
          '';

          systemd.tmpfiles.rules = [
            "f /dev/shm/looking-glass 0660 ${userSettings.username} kvm -"
          ];
        };
      };

      users.users.${userSettings.username}.extraGroups = [ "libvirtd" ];
    };
}
