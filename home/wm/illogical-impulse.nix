{ inputs, pkgs, ... }:
{
	imports = [
		inputs.illogical-impulse.homeManagerModules.default
	];

	illogical-impulse = {
		enable = true;

		hyprland = {
			package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
			portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;

			# Enable Wayland ozone
			ozoneWayland.enable = true;
		};

		# Dotfiles configurations
		dotfiles = {
			anyrun.enable = true;
			fish.enable = true;
			kitty.enable = true;
		};
	};
}
