{ pkgs, ... }: {
	home.packages = with pkgs; [
		gnome-tweaks
		gnome-extension-manager
	];
}
