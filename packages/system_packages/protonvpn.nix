{ inputs, ... }:
{
	imports = [
		inputs.erosanix.nixosModules.protonvpn
	];

	environment.systemPackages = with pkgs; [
		erosanix.packages.x86_64-linux.protonvpn
	];
}
