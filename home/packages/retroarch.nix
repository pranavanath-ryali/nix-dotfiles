{ pkgs, ... }:
{
    home.packages = with pkgs; [
        (retroarch.withCores (cores: with cores; [
            # gambatte
            # mgba
            # mupen64plus
            
            # swanstation
            # ppsspp

            # mame
            snes9x
            # nestopia
        ]))
    ];
}
