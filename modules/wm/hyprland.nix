{ userSettings, ... }:
{
  flake.nixosModules.hyprland = { pkgs, pkgs-unstable, ... }: {
    programs.hyprland = {
      enable = true;
      package = pkgs-unstable.hyprland;
      portalPackage = pkgs-unstable.xdg-desktop-portal-hyprland;
    };

    services.gnome.gnome-keyring.enable = true;
    security.pam.services.gdm.enableGnomeKeyring = true;

    # Mountable Drives
    services.devmon.enable = true;
    services.gvfs.enable = true;
    services.udisks2.enable = true;
  };

  flake.homeModules.hyprland = { lib, pkgs, pkgs-unstable, ... }: {
    home.packages = with pkgs; [
      wireplumber
      brightnessctl
      playerctl
    ];

    wayland.windowManager.hyprland = {
      enable = true;
      package = pkgs-unstable.hyprland;
      portalPackage = pkgs-unstable.xdg-desktop-portal-hyprland;
    };


    home.file."/home/${userSettings.username}/.config/hypr/rice/nothing.lua".text = ''
-- this file exists to purely create this 'rice' directory
    '';

    home.file."/home/${userSettings.username}/.config/hypr/hyprland.lua" = lib.mkForce {
      text = ''
require("./rice/*")

hl.on("hyprland.start", function()
  hl.exec_cmd("bash ~/platform_power_profile.sh")
end)

hl.monitor({ output = "", mode = "preferred", scale = "1", position = "auto" })

hl.config({
    input = {
        accel_profile = "adaptive",
        kb_layout = "${userSettings.xkb_layout}",
        kb_variant = "${userSettings.xkb_variant}",

        touchpad = {
            clickfinger_behavior = true,
            natural_scroll = true,
        }
    },
})

hl.window_rule({
  name = "transparency-on-nautilus",
  match = { class = "org.gnome.Nautilus" },
  opacity = "0.8"
})
hl.window_rule({
  name = "transparency-on-fileroller",
  match = { class = "org.gnome.FileRoller" },
  opacity = "0.8"
})

hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind("SUPER + Q", hl.dsp.window.close())
hl.bind("SUPER + M", hl.dsp.window.fullscreen({ action = "toggle", mode = "maximized" }))
hl.bind("SUPER + F11", hl.dsp.window.fullscreen_state({ action = "toggle", internal = 2, client = 2 }))
hl.bind("SUPER + SHIFT + F11", hl.dsp.window.fullscreen_state({ action = "toggle", internal = 0, client = 2 }))
hl.bind("SUPER + V", hl.dsp.window.float())
hl.bind("SUPER + E", hl.dsp.exec_cmd("nautilus"))

for i, key in ipairs({ '1', '2', '3', '4', '5', 'F', 'P' }) do
    hl.bind("SUPER +" .. key, hl.dsp.focus({ workspace = i }))
    hl.bind("SUPER + SHIFT +" .. key, hl.dsp.window.move({ window = "activewindow", workspace = i }))
end

hl.bind("SUPER + W", hl.dsp.focus({ direction = "u" }))
hl.bind("SUPER + R", hl.dsp.focus({ direction = "d" }))
hl.bind("SUPER + A", hl.dsp.focus({ direction = "l" }))
hl.bind("SUPER + S", hl.dsp.focus({ direction = "r" }))

hl.bind("SUPER + SHIFT + W", hl.dsp.window.swap({ direction = "u" }))
hl.bind("SUPER + SHIFT + R", hl.dsp.window.swap({ direction = "d" }))
hl.bind("SUPER + SHIFT + A", hl.dsp.window.swap({ direction = "l" }))
hl.bind("SUPER + SHIFT + S", hl.dsp.window.swap({ direction = "r" }))

hl.bind("SUPER + SHIFT + UP", hl.dsp.window.move({ window = "tiled", direction = "u" }))
hl.bind("SUPER + SHIFT + DOWN", hl.dsp.window.move({ window = "tiled", direction = "d" }))
hl.bind("SUPER + SHIFT + LEFT", hl.dsp.window.move({ window = "tiled", direction = "l" }))
hl.bind("SUPER + SHIFT + RIGHT", hl.dsp.window.move({ window = "tiled", direction = "r" }))

resize_step = 50
hl.bind("SUPER + CONTROL + W", hl.dsp.window.resize({ x = 0, y = -resize_step, relative = true }))
hl.bind("SUPER + CONTROL + S", hl.dsp.window.resize({ x = resize_step, y = 0, relative = true }))
hl.bind("SUPER + CONTROL + R", hl.dsp.window.resize({ x = 0, y = resize_step, relative = true }))
hl.bind("SUPER + CONTROL + A", hl.dsp.window.resize({ x = -resize_step, y = 0, relative = true }))

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 1%+"))
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 1%-"))
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"))
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"))

hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl set 2%+"))
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 2%-"))

hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"))
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"))
hl.bind("XF86AudioStop", hl.dsp.exec_cmd("playerctl stop"))
      '';
    };

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
  };
}
