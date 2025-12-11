{ pkgs, userSettings, ... }:
{
	programs.fish = {
		enable = true;
		interactiveShellInit = ''
			set fish_greeting # Disable greeting
		'';
	};

	users.users.${userSettings.username} = {
		shell = pkgs.fish;
	};
}
