{ config, pkgs, ... }:
{
    home.packages = with pkgs; [
        virt-manager     # GUI for managing VMs
        qemu_kvm         # QEMU with KVM acceleration
        virt-viewer      # Optional, for viewing VM consoles
    ];

    # programs.bash.shellAliases = {
    #     kvm-ok = "egrep -c '(vmx|svm)' /proc/cpuinfo";
    # };

    services.dbus.enable = true;
}
