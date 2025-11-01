{ pkgs, ... }:
{
	home.packages = [ pkgs.qimgv ];
	xdg.mimeApps.defaultApplications = {
		"image/jpeg" = [ "qimgv.desktop" ];
		"image/png" = [ "qimgv.desktop" ];
	};
}
