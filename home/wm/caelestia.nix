{ inputs, pkgs, systemSettings, ... }:
{
    imports = [
        ./niri-common.nix
        ./dms/config.nix


        
        ../packages/terminal/kitty.nix
        ../../home/packages/mpv.nix
    ];

    home.packages = with pkgs; [
        inputs.caelestia-shell.packages.${systemSettings.system}.default

        pwvucontrol

        nautilus
        papers
        file-roller
        loupe

        playerctl
        brightnessctl
    ];

	xdg.mimeApps.defaultApplications = {
		"image/jpeg" = [ "org.gnome.Loupe.desktop" ];
		"image/png" = [ "org.gnome.Loupe.desktop" ];
	};
}
