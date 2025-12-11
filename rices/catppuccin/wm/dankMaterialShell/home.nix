{ ... }:
{
    programs.kitty = {
        font.size = 12;
        settings = {
            window_padding_width = [ 2 2 ];
            background_opacity = 1.0;
            cursor_trail = 1;
            hide_window_decorations = true;
        };
        extraConfig = ''
            include dank-theme.conf
            include dank-tabs.conf
        '';
    };
}
