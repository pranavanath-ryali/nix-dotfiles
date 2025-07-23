{ appimageTools, fetchurl, ... }:
let
	gdlauncher = import ../derivations/gdlauncher.nix {
		inherit appimageTools fetchurl;
	};
in
{
	home.packages = [ gdlauncher ];
}
