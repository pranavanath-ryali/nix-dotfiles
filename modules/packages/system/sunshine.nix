{ userSettings, ... }:
{
  flake.nixosModules.sunshineModule = { ... }: {
    services.sunshine = {
      enable = true;
      autoStart = true;
      capSysAdmin = true; # only needed for Wayland -- omit this when using with Xorg
      openFirewall = true;
    };

    users.users.${userSettings.username} = {
      extraGroups = [ "uinput" ];
    };
    hardware.uinput.enable = true;
  };
}
