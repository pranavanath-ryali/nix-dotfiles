{ inputs, pkgs, ... }:
{
    imports = [
        ./niri-common.nix
        ./dms/config.nix
        inputs.dankMaterialShell.homeModules.dankMaterialShell.default
        inputs.dankMaterialShell.homeModules.dankMaterialShell.niri
        
        ../packages/terminal/kitty.nix
        ../../home/packages/mpv.nix
    ];

    home.packages = with pkgs; [
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

    programs.dankMaterialShell = {
        enable = true;
        niri = {
            enableKeybinds = false;
            enableSpawn = true;
        };
    };
}
