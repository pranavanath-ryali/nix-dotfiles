{ pkgs, userSettings, ... }:
{
    boot.kernelModules = [ "kvm-intel" ];

    programs.virt-manager.enable = true;
    virtualisation.spiceUSBRedirection.enable = true;
    virtualisation.libvirtd.enable = true;

    users.users.${userSettings.username}.extraGroups = [ "libvirtd" "qemu-libvirtd" "wheel" "video" ];

    environment.systemPackages = with pkgs; [
        qemu # Core QEMU tools
        libvirt # For libvirtd service
        virt-manager # GUI management
    ];
}
