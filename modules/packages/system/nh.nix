{ userSettings, ... }:
{
  flake.homeModules.nh = { ... }: {
    programs.nh = {
      enable = true;
      flake = "/home/${userSettings.username}/.dotfiles";
    };
  };
}
