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
        systemd = {
          enable = true;
          autoStart = true;
        };
      };
    };
}
