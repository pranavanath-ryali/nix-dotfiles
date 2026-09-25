{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/release-26.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:vic/import-tree";

    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";

    home-manager.url = "github:nix-community/home-manager/release-26.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # i915-SRIOV Module
    i915-sriov.url = "github:strongtz/i915-sriov-dkms/master";
    i915-sriov.inputs.nixpkgs.follows = "nixpkgs";

    # Hyprland
    hyprland.url = "github:hyprwm/Hyprland";

    # MangoWM
    mangowm = {
      url = "github:mangowm/mango";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Noctalia Shell
    noctalia.url = "github:noctalia-dev/noctalia";
    noctalia.inputs.nixpkgs.follows = "nixpkgs";

    # NVF
    nvf.url = "github:NotAShelf/nvf";
    nvf.inputs.nixpkgs.follows = "nixpkgs";

    # Zen Browser
    zen-browser.url = "github:youwen5/zen-browser-flake";
    zen-browser.inputs.nixpkgs.follows = "nixpkgs";

    # Helium Browser
    helium.url = "github:schembriaiden/helium-browser-nix-flake";
    helium.inputs.nixpkgs.follows = "nixpkgs";

    # Vicinae
    vicinae.url = "github:vicinaehq/vicinae";

    # San Francisco Fonts | Apple Fonts
    apple-fonts.url = "github:Lyndeno/apple-fonts.nix";
    apple-fonts.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs@{
      chaotic,
      flake-parts,
      import-tree,
      ...
    }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [ (import-tree ./modules) ];

      _module.args = {
        userSettings = {
          username = "pranavanath";
        };

        globalSettings = {
          wm = "mangowm";
          rice = "modern-glass";
          browser = "zen";
          virtualization = true;

          allowedTCPPorts = [
            53317

            2283
            4533
            5000
          ];
          allowedUDPPortRanges = [
            {
              from = 4000;
              to = 4007;
            }
            {
              from = 53315;
              to = 53318;
            }
            {
              from = 8000;
              to = 8010;
            }
          ];
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
            ];

            shellHook = ''
              echo "Welcome to the nix development environment"
            '';
          };
        };
    };
}
