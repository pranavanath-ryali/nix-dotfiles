{ pkgs, ... }:
{
    imports = [
        ../../home/packages/direnv.nix
    ];

    programs.fish = {
      enable = true;
      interactiveShellInit = ''
  set fish_greeting # Disable greeting

  alias gd="__NV_PRIME_RENDER_OFFLOAD=0 __GLX_VENDOR_LIBRARY_NAME=nvidia gdlauncher"
  alias dots="cd ~/.dotfiles && nvim ."
  alias caffine="systemd-inhibit cmatrix"
      '';
      plugins = [
        { name = "grc"; src = pkgs.fishPlugins.grc.src; }
        { name = "tide"; src = pkgs.fishPlugins.tide.src; }
        { name = "z"; src = pkgs.fishPlugins.z.src; }
      ];
    };
}
