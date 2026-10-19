{ userSettings, ... }:
{
  flake.homeModules.emacs = { pkgs, ... }: {
    home.packages = with pkgs; [
      emacs-pgtk

      git
      ripgrep
      fd
      clang
      # gcc
    ];

    services.emacs = {
      enable = true;
      package = pkgs.emacs-pgtk;
      defaultEditor = true;
      client.enable = true;
      extraOptions = [
        "--init-directory" "/home/${userSettings.username}/.config/emacs"
      ];
    };

    systemd.user.sessionVariables = {
      DOOMDIR = "/home/${userSettings.username}/.config/doom";
      EMACSDIR = "/home/${userSettings.username}/.config/emacs";
    };
  };
}
