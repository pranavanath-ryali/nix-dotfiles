{ pkgs, ... }:
{
    services.emacs = {
        enable = true;
        package = pkgs.emacs;
        extraOptions = [
            "--daemon"
        ];
    };

    programs.emacs = {
        enable = true;
        package = pkgs.emacs;
    };
  }
