{ ... }:
{
  flake.homeModules.fishModule = { pkgs, ... }: {
    programs.fish = {
      enable = true;
      interactiveShellInit = ''
        set fish_greeting # Disable greeting
        direnv hook fish | source
                 		'';
      plugins = [
        {
          name = "z";
          src = pkgs.fishPlugins.z.src;
        }
        {
          name = "grc";
          src = pkgs.fishPlugins.grc.src;
        }
        {
          name = "autopair";
          src = pkgs.fishPlugins.autopair.src;
        }
        {
          name = "pure";
          src = pkgs.fishPlugins.pure.src;
        }
      ];
    };

    programs.kitty.shellIntegration.enableFishIntegration = true;
    programs.kitty.extraConfig = ''
      shell fish
    '';
  };
}
