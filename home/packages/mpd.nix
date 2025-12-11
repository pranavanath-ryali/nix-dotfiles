{ pkgs, userSettings, ... }:
{
	services.mpd = {
		enable = true;
		musicDirectory = userSettings.musicDir;
		extraConfig =
		''
			audio_output {
				type "pipewire"
				name "MPD Audio Player"
			}
		'';
	};

	# services.mpdris2 = {
	# 	enable = true;

	# 	notifications = true;
	# 	mpd.musicDirectory = userSettings.musicDir;
	# };

	home.packages = with pkgs; [
		mpdris2-rs

		mpd
		mpc 
		sutils
	];
}
