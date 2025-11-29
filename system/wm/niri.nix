{ inputs, pkgs, ... }:
{
    imports = [
        ./wayland.nix
        ./gnome-keyring.nix

        inputs.niri.nixosModules.niri
    ];

    services.displayManager.gdm.enable = true;
    programs.niri = {
        enable = true;
    };
}
