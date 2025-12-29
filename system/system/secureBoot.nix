{ lib, inputs, pkgs, systemSettings, ... }:
lib.mkIf (systemSettings.useSecureboot)
{
    environment.systemPackages = [
        pkgs.sbctl
    ];

    boot.loader.systemd-boot.enable = lib.mkForce false;
    boot.lanzaboote = {
        enable = true;
        pkiBundle = "/var/lib/sbctl";
    };
}
