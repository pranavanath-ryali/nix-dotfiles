{
  outputs = inputs@{ flake-parts, import-tree, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [ (import-tree ./modules) ];
      _module.args = {
        userSettings = {
          username = "pranavanath";

          xkb_layout = "us";
          xkb_variant = "colemak_dh";
        };
      };

      perSystem =
        { config, pkgs, ... }:
        {
          devShells.default = pkgs.mkShell {
            name = "dotfiles-env";

            packages = with pkgs; [
              git
              nixfmt
              nil
            ];

            shellHook = ''
              echo "Welcome to the nix development environment"
            '';
          };
        };
    };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/release-26.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:vic/import-tree";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    san-francisco-fonts = {
      url = "github:Lyndeno/apple-fonts.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ghostty-cursor-shaders = {
      url = "github:sahaj-b/cursor-shaders";
      flake = false;
    };
  };
}
