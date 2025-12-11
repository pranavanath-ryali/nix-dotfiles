{ pkgs, ... }:
{
    fonts = {
        # TODO: Its best if this is system wide rather than theme specific
        enableDefaultPackages = true;
        packages = with pkgs; [
            dm-sans
            nerd-fonts.mononoki
            
            # Might want to move these system wide
            ubuntu-classic
            liberation_ttf
        ];

        fontconfig = {
            enable = true;
            antialias = true;
            hinting = {
                enable = true;
                style = "full";
            };
            defaultFonts = {
                serif = [ "DeepMind Sans" "Ubuntu" ];
                sansSerif = [ "DeepMind Sans" "Ubuntu" ];
                monospace = [ "Mononoki Nerd Font" "Ubuntu Mono" ];
                emoji = [ "Noto Color Emoji" ];
            };
        };
    };
}
