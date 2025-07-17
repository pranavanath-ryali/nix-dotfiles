{ pkgs, userSettings, ... }:
{
	services.mpd = {
		enable = true;
		musicDirectory = userSettings.music_dir;
		extraConfig =
''
audio_output {
	type "pipewire"
	name "MPD Audio Player"
}
'';
	};

	services.mpdris2 = {
		enable = true;

		notifications = true;
		mpd.musicDirectory = userSettings.musicDir;
	};

	home.packages = with pkgs; [ mpd mpdris2 mpc sutils ];
}