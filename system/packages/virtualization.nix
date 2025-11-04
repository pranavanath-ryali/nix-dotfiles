{ pkgs, userSettings, ... }:
{
    # virtualisation.libvirtd.enable = true;
    # virtualisation.libvirtd.qemu.package = pkgs.qemu_kvm;
    #
    # virtualisation.libvirtd.networks.default.enable = true;
    #

    # virtualisation.libvirtd = {
    #     enable = true;
    #     qemu = {
    #         package = pkgs.qemu_kvm;
    #         runAsRoot = true;
    #         swtpm.enable = true;
    #         # ovmf = { # not needed in NixOS 25.11 since https://github.com/NixOS/nixpkgs/pull/421549
    #         #     enable = true;
    #         #     packages = [(pkgs.OVMF.override {
    #         #         secureBoot = true;
    #         #         tpmSupport = true;
    #         #     }).fd];
    #         # };
    #     };
    # };

    users.users.${userSettings.username}.extraGroups = [ "libvirtd" ];

    environment.systemPackages = with pkgs; [
        virt-manager
        virt-viewer

        spice 
        spice-gtk
        spice-protocol

        # win-virtio
        # win-spice
        # gnome.adwaita-icon-theme
    ];

    virtualisation = {
        libvirtd = {
            enable = true;
            qemu = {
                swtpm.enable = true;
                # ovmf.enable = true;
                # ovmf.packages = [ pkgs.OVMFFull.fd ];
            };
        };
        spiceUSBRedirection.enable = true;
    };
    services.spice-vdagentd.enable = true;
}
