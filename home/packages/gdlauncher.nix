{ pkgs, ... }:
let
	gdlauncher = import ../../derivations/gdlauncher.nix {
		inherit (pkgs) appimageTools fetchurl;
	};
in
{
	home.packages = [ gdlauncher ];
}
