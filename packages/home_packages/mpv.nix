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
}
