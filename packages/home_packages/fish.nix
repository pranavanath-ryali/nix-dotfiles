{ pkgs, ... }:
{
	programs.fish = {
		enable = true;
		interactiveShellInit = ''
set fish_greeting # Disable greeting

alias gd="__NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia gdlauncher"
alias dots="cd ~/.dotfiles && nvim ."
alias wiki="cd ~/vimwiki && nvim index.wiki"
alias caffine="systemd-inhibit cmatrix"
alias disable_dgpu="sudo /bin/sh -c 'echo 1 > /sys/bus/pci/devices/0000:02:00.0/remove'"
		'';
		plugins = [
			{ name = "grc"; src = pkgs.fishPlugins.grc.src; }
			{ name = "tide"; src = pkgs.fishPlugins.tide.src; }
			{ name = "z"; src = pkgs.fishPlugins.z.src; }
		];
	};
}
