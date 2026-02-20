{ pkgs, ... }:
{
    programs.kitty = {
        font.name = "Mononoki Nerd Font";
        font.size = 12;
        settings = {
            window_padding_width = 2;
            background_opacity = 1.0;
            cursor_trail = 1;
            hide_window_decorations = true;
        };
        extraConfig = ''
            include dank-theme.conf
            include dank-tabs.conf
        '';
    };

    programs.nixvim = {
        colorschemes.catppuccin.enable = true;
    };

    # gtk = {
    #     enable = true;
    #     iconTheme = {
    #         name = "MacTahoe-Dark";
    #         package = (
    #             import ../../packages/mactahoe-icon-theme.nix {
    #                 inherit pkgs;
    #                 stdenv = pkgs.stdenv;
    #                 fetchFromGitHub = pkgs.fetchFromGitHub;
    #             }
    #         );
    #     };
    # };
}
