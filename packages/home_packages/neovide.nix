{ pkgs, ... }:
{
    programs.neovide = {
        enable = true;
        package = pkgs.neovide;
        settings = {
            font = {
                normal = [ "monospace" ];
                size = 12.0;
            };
        };
    };
}