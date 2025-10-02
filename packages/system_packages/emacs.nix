{ pkgs, ... }:
{
	services.emacs = {
		enable = true;
		package = pkgs.emacs;
		exec = "emacs --daemon --load ~/.config/emacs";
	};
}
