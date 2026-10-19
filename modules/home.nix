{ inputs, self, userSettings, ... }:
{
  flake.homeModules.homeConfiguration = { self, ... }: {
    imports = [
      self.homeModules.defaultPackages
      self.homeModules.nh
      self.homeModules.rmpc
      self.homeModules.bottles
      self.homeModules.fish
      self.homeModules.emacs

      self.homeModules.hyprland
      self.homeModules.modernSimpleRice
    ];

    programs.home-manager.enable = true;

    home.username = "${userSettings.username}";
    home.homeDirectory = "/home/${userSettings.username}";
    home.stateVersion = "26.05";
  };

  flake.homeConfigurations.${userSettings.username} = inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = import inputs.nixpkgs {
      system = "x86_64-linux";
      config.allowUnfree = true;
    };

    extraSpecialArgs = {
      inherit self;
      inherit inputs;

      pkgs-unstable = import inputs.nixpkgs-unstable {
        system = "x86_64-linux";
        config.allowUnfree = true;
      };
    };

    modules = [
      self.homeModules.homeConfiguration
    ];
  };
}
