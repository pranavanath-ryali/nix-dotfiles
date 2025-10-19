{ inputs, pkgs, ... }:
{
	# imports = [
	# 	inputs.erosanix.nixosModules.protonvpn
	# ];

	# networking.firewall.enable = false;
	networking.firewall.checkReversePath = "loose";
	networking.useDHCP = false;

	environment.systemPackages = with pkgs; [
		# inputs.erosanix.packages.x86_64-linux.protonvpn

		protonvpn-gui
		wireguard-tools
	];
}
