{ ... }:
{
  flake.homeModules.mangowmModernGlassRice = { self, ... }: {
    imports = [
      self.homeModules.kittyModule
      self.homeModules.fishModule
    ];
  };
}
