{ pkgs, ... }:
{
	# home.packages = with pkgs; [
	# 	(
	# 		mpv.override {
	# 			scripts = [
	# 				mpvScripts.uosc
	# 			];
	# 		}
	# 	)
	# ];
	#
	programs.mpv = {
		enable = true;

		package = (
			pkgs.mpv-unwrapped.wrapper {
				scripts = with pkgs.mpvScripts; [
					uosc
				];

				mpv = pkgs.mpv-unwrapped.override {
					waylandSupport = true;
				};
			}
		);

		config = {
			cache-default = 4000000;
		};
	};

	xdg.mimeApps.defaultApplications = {
		"video/x-msvideo" = [ "mpv.desktop" ];
		"video/mp4" = [ "mpv.desktop" ];
		"video/x-matroska" = [ "mpv.desktop" ];
		"video/mpeg" = [ "mpv.desktop" ];
		"video/x-wav" = [ "mpv.desktop" ];
	};
}
