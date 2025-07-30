{ pkgs, ... }:
{
	imports = [ ./wayland.nix ];

	services.displayManager.sddm.enable = true;
	services.displayManager.sddm.wayland.enable = true;
	services.desktopManager.plasma6.enable = true;

	environment.systemPackages = with pkgs; [
		kdePackages.kcalc
		kdePackages.kcharselect
		kdePackages.kcolorchooser
		kdePackages.kolourpaint
		kdePackages.ksystemlog
		kdePackages.sddm-kcm
		kdiff3
		kdePackages.partitionmanager
		hardinfo2
		haruna
		wayland-utils
		wl-clipboard
	];
}
