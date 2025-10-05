{ pkgs, ... }:
{
	services.emacs = {
		enable = true;
		package = pkgs.emacs;
		extraOptions = [
			"--daemon"
			"--load ~/.config/emacs/init.el"
		];
	};

	programs.emacs = {
		enable = true;
		package = pkgs.emacs;
	};
}
