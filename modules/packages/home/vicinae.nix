{ ... }:
{
  flake.homeModules.vicinaeModule =
    {
      options,
      config,
      lib,
      inputs,
      ...
    }:
    {
      programs.vicinae = {
        enable = true;
        useLayerShell = true;
        systemd = {
          enable = true;
          autoStart = true;
        };
      };
    };
}
