{
  inputs,
  self,
  globalSettings,
  userSettings,
  ...
}:
{
  flake.homeConfigurations.${userSettings.username} =
    inputs.home-manager.lib.homeManagerConfiguration
      {
        pkgs = import inputs.nixpkgs {
          system = "x86_64-linux";
          config.allowUnfree = true;
        };
        extraSpecialArgs = {
          inherit self;
          inherit inputs;
        };
        modules = [
          self.homeModules.homeModule
          {
            home.username = "${userSettings.username}";
            home.homeDirectory = "/home/${userSettings.username}";
            home.stateVersion = "25.11";
          }
        ];
      };

  flake.homeModules.homeModule =
    {
      self,
      pkgs,
      lib,
      hostname,
      ...
    }:
    {
      imports = [
        self.homeModules.basePackages

        # self.homeModules.defaultNoctaliaHyprland
      ]
      # Load wm
      ++ lib.optional (globalSettings.wm == "hyprland") self.homeModules.hyprlandModule
      ++ lib.optional (globalSettings.wm == "mangowm") self.homeModules.mangowmModule
      # Load rice
      ++ lib.optional (globalSettings.rice == "pitch-black") self.homeModules.pitchBlackRice
      ++ lib.optional (globalSettings.rice == "modern-glass") self.homeModules.modernGlassRice;

      programs.home-manager.enable = true;
    };
}
