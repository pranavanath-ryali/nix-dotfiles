{ pkgs, ... }:
{
	home.packages = [ pkgs.vlc ];

	xdg.mimeApps.defaultApplications = {
		"video/x-msvideo" = [ "vlc.desktop" ];
		"video/mp4" = [ "vlc.desktop" ];
		"video/x-matroska" = [ "vlc.desktop" ];
		"video/mpeg" = [ "vlc.desktop" ];
		"video/x-wav" = [ "vlc.desktop" ];
	};
}
