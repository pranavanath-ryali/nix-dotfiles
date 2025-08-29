{ pkgs, ... }:
{
	home.packages = [ pkgs.zathura ];

	xdg.mimeApps.defaultApplications = {
		"application/pdf" = [ "zathura.desktop" ];
	};
}
