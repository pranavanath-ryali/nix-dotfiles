{ ... }:
{
  flake.homeModules.bottles = { pkgs-unstable, ... }: {
    home.packages = [
      pkgs-unstable.bottles
    ];
  };
}
