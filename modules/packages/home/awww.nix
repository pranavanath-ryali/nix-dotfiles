{ ... }:
{
    flake.homeModules.awwwModule = { inputs, pkgs, lib, ... }: {
        home.packages = [
          pkgs.awww
            # inputs.awww.packages.${pkgs.stdenv.hostPlatform.system}.awww
        ];
    };
}
