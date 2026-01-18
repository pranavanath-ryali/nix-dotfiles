{ inputs, pkgs, ... }:
{
    imports = [
        inputs.vicinae.homeManagerModules.default
    ];

    services.vicinae = {
        enable = true;
        package = pkgs.vicinae;
        systemd = {
            enable = true;
            autoStart = true;
            environment = {
                USE_LAYER_SHELL = 1;
            };
        };
        settings = {
            close_on_focus_loss = true;
            launcher_window = {
                opacity = 0.98;
            };
        };
        extensions = with inputs.vicinae-extensions.packages.${pkgs.stdenv.hostPlatform.system}; [
            wifi-commander
            bluetooth
            fuzzy-files
            awww-switcher
            nix
            power-profile
        ];
    };
}
