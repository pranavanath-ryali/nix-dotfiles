{ ... }:
{
  flake.homeModules.kittyModule = { lib, ... }: {
    programs.kitty = {
      enable = true;
      enableGitIntegration = true;
    };
  };
}
