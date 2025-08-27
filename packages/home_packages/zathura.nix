{ pkgs, ... }:
{
	home.packages = [ pkgs.zathura ];

	home.xdg.mimeApps = {
		enable = true;
		defaultApplications = {
			"application/pdf" = [ "zathura.desktop" ];
		};
	};
}
