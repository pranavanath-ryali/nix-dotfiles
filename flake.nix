{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/release-26.05";
    nixpkgs-2511.url = "github:NixOS/nixpkgs/release-25.11";
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
          rice = "none";
          browser = "zen";
          virtualization = true;
          openPorts = [
            4533
            5000
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
