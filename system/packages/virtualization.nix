{ pkgs, userSettings, ... }:
{
    virtualisation.libvirtd.enable = true;
    virtualisation.libvirtd.qemu.package = pkgs.qemu_kvm;
    virtualisation.libvirtd.networks.default.enable = true;
    users.users.${userSettings.username}.extraGroups = [ "libvirtd" ];
}
