{ pkgs, ... }:
{
	programs.rofi = {
		enable = true;
		font = "monospace 12";
		terminal = "${pkgs.kitty}/bin/kitty";
		modes = [
			"drun"
			"filebrowser"
		];
	};
}
