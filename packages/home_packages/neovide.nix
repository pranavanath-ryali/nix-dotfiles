{ pkgs, lib, ... }:
{
    programs.neovide = {
        enable = true;
        package = pkgs.neovide;
        settings = {
            font = {
                normal = [ "monospace" ];
                size = lib.mkForce 12.0;
            };
        };
    };
}