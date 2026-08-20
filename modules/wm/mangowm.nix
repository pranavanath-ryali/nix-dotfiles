{ userSettings, ... }:
{
  flake.nixosModules.mangowmModule = { inputs, pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      wayland
      wireplumber
    ];

    services.xserver = {
      enable = true;
      xkb = {
        layout = "us";
        variant = "colemak_dh";
      };
    };

    programs.mango = {
      enable = true;
      package = inputs.mango.packages.${pkgs.stdenv.hostPlatform.system}.mango;
    };
    services.gnome.gnome-keyring.enable = true;

    # Mountable Drives
    services.devmon.enable = true;
    services.gvfs.enable = true;
    services.udisks2.enable = true;
  };

  flake.homeModules.mangowmModule = { inputs, pkgs, ... }: {

    home.file."/home/${userSettings.username}/platform_power_profile.sh" = {
      executable = true;
      text = ''
        FILE="/sys/firmware/acpi/platform_profile"

        inotifywait -m -e modify "$FILE" --format '%w%f' | while read FILE_CHANGED
        do
            PROFILE=$(cat "$FILE_CHANGED")

            case "$PROFILE" in
                low-power)
                    MSG="Power Saver Mode"
                    ;;
                balanced)
                    MSG="Balanced Mode"
                    ;;
                performance)
                    MSG="Performance Mode"
                    ;;
                *)
                    MSG="Unknown mode: $PROFILE"
                    ;;
            esac

            notify-send "Lenovo Fn+Q" "$MSG"
        done
      '';
    };

    wayland.windowManager.mango = {
      enable = true;
      package = inputs.mango.packages.${pkgs.stdenv.hostPlatform.system}.mango;

      autostart_sh = ''
        bash /home/${userSettings.username}/platform_power_profile.sh &
        gammastep -O 7250 &
      '';
    };
  };
}
