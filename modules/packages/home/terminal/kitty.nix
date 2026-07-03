{ ... }:
{
  flake.homeModules.kittyModule = { lib, ... }: {
    programs.kitty = {
      enable = true;
      enableGitIntegration = true;

      font.name = lib.mkDefault "CaskaydiaCove NF";
      font.size = lib.mkDefault 12;
    };
  };
}
