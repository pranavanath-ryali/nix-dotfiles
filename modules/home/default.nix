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
      # Load rice
      ++ lib.optional (globalSettings.rice == "pitch-black") self.homeModules.pitchBlackRice;

      programs.home-manager.enable = true;

    #   home.file."/home/${userSettings.username}/platform_power_profile.sh" = {
    #     executable = true;
    #     text = ''
    #       FILE="/sys/firmware/acpi/platform_profile"
    #
    #       inotifywait -m -e modify "$FILE" --format '%w%f' | while read FILE_CHANGED
    #       do
    #           PROFILE=$(cat "$FILE_CHANGED")
    #
    #           case "$PROFILE" in
    #               low-power)
    #                   MSG="Power Saver Mode"
    #                   ;;
    #               balanced)
    #                   MSG="Balanced Mode"
    #                   ;;
    #               performance)
    #                   MSG="Performance Mode"
    #                   ;;
    #               *)
    #                   MSG="Unknown mode: $PROFILE"
    #                   ;;
    #           esac
    #
    #           notify-send "Lenovo Fn+Q" "$MSG"
    #       done
    #     '';
    #   };
    #
    #   wayland.windowManager.hyprland.settings.exec-once = lib.mkAfter [
    #     "bash /home/${userSettings.username}/platform_power_profile.sh"
    #   ];
    };
}
