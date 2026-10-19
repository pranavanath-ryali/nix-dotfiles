{ ... }:
{
  flake.homeModules.defaultPackages = { pkgs, ... }: {
    home.packages = with pkgs; [
      floorp-bin
      alacritty

      zed-editor
      inotify-tools
      libnotify

      easyeffects
      strawberry
      lrcget

      obsidian

      nautilus
      file-roller
      sushi
      papers
    ];
  };

  flake.nixosModules.defaultPackages = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      btop
      bat
      wireplumber
      jack2
      qjackctl

      vim
      git
      gh
      grc
      jq
      curl
      wget
      unzip

      gparted
    ];
  };
}
