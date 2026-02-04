{ inputs, config, systemSettings, pkgs, ... }:
{
    imports = [
        # inputs.matugen.nixosModules.default
    ];

    home.packages = with pkgs; [
        # inputs.matugen.packages.${systemSettings.system}.default

        matugen
        nerd-fonts.caskaydia-cove
    ];

    home.file."~/.config/matugen/config".source = ../../matugen/config.toml;
    home.file."~/.config/matugen/templates".source = ../../matugen/templates;

    # programs.matugen = {
    #     enable = true;
    #     # templates = {
    #     #     kitty = {
    #     #         input_path = ../../../../assets/matugen-templates/kitty-colors.conf;
    #     #         output_path = "~/.config/kitty/colors.conf";
    #     #     };
    #     #
    #     #     # gtk = {
    #     #     #     input_path = ../../../../assets/matugen-templates/gtk-colors.css;
    #     #     #     output_path = "~/.config/gtk-4.0/gtk.css";
    #     #     # };
    #     #
    #     #     # hypr = {
    #     #     #     input_path = "./templates/hypr.conf";
    #     #     #     output_path = "~/.config/hypr/colors.conf";
    #     #     # };
    #     # };
    # };

    gtk = {
        enable = true;
        font = {
            name = "CaskaydiaCove Nerd Font";
            package = pkgs.nerd-fonts.caskaydia-cove;
            size = 11;
        };

        # gtk4.extraCss = "@import url(\"${config.programs.matugen.theme.files}/.config/gtk-4.0/gtk.css\");";
        # gtk3.extraCss = "@import url(\"${config.programs.matugen.theme.files}/.config/gtk-3.0/gtk.css\");";
    };

    programs.kitty = {
        font.name = "CaskaydiaCove Nerd Font";
        font.size = 10;
        settings = {
            window_padding_width = "8 8";
            background_opacity = 0.7;
            cursor_trail = 1;
            hide_window_decorations = "yes";
        };
    };
}
