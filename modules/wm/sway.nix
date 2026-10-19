{ ... }:
{
  flake.nixosModules.sway = { ... }: {
    programs.sway.enable = true;

    services.gnome.gnome-keyring.enable = true;
    security.pam.services.gdm.enableGnomeKeyring = true;

    # Mountable Drives
    services.devmon.enable = true;
    services.gvfs.enable = true;
    services.udisks2.enable = true;
  };

  flake.homeModules.sway = { ... }: {
    # security.polkit.enable = true;

    wayland.windowManager.sway = {
      enable = true;
      wrapperFeatures.gtk = true;

      config = rec {
        modifier = "Mod4";
        terminal = "kitty";
      };
    };
  };
}
