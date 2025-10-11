{ pkgs, ... }:
{
	home.packages = [ pkgs.zathura ];

	xdg.mimeApps.defaultApplications = {
		"application/pdf" = [ "org.pwmt.zathura-pdf-mupdf.desktop" ];
	};
}
