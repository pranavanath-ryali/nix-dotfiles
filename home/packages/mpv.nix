{ pkgs, ... }:
{
	programs.mpv = {
		enable = true;

		package = (
			pkgs.mpv-unwrapped.wrapper {
				scripts = with pkgs.mpvScripts; [
					uosc
					thumbfast
				];

				mpv = pkgs.mpv-unwrapped.override {
					waylandSupport = true;
				};
			}
		);
	};

	xdg.mimeApps.defaultApplications = {
		"video/x-msvideo" = [ "mpv.desktop" ];
		"video/mp4" = [ "mpv.desktop" ];
		"video/x-matroska" = [ "mpv.desktop" ];
		"video/mpeg" = [ "mpv.desktop" ];
		"video/x-wav" = [ "mpv.desktop" ];
	};

	home.packages = [ pkgs.youtube-tui ];
}
