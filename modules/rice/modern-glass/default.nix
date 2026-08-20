{ ... }:
{
    flake.nixosModules.modernGlassRice = { inputs, pkgs, ... }: {
        fonts.packages = [
            inputs.apple-fonts.packages.${pkgs.system}.sf-pro-nerd

            pkgs.nerd-fonts.martian-mono
        ];
    };

    flake.homeModules.modernGlassRice = { self, ... }: {
        imports = [
            self.homeModules.mangowmModernGlassRice
        ];
    };
}
