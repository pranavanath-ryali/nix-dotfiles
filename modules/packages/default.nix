{ globalSettings, ... }:
{
  flake.nixosModules.basePackages =
    {
      self,
      pkgs,
      ...
    }:
    {
      imports = [
        self.nixosModules.direnvModule
        self.nixosModules.steamModule
        self.nixosModules.flatpakModule
        self.nixosModules.nixosContainerModule
        self.nixosModules.virtualizationModule
        self.nixosModules.dockerModule
      ];

      environment.systemPackages = with pkgs; [
        gsettings-desktop-schemas
        zed-editor

        powertop
        nvme-cli

        btop
        htop
        ranger
        grc
        ripgrep
        bat
        pciutils
        ispell
        inotify-tools
        libnotify
        wireplumber
        qjackctl
        pavucontrol

        git
        gh

        vim
        wget
        curl
        unzip
        cmatrix

        gcc

        jack2
        qjackctl

        adw-gtk3
        papirus-icon-theme
      ];

      programs.dconf.enable = true;

      fonts.packages = with pkgs; [
        nerd-fonts.jetbrains-mono
        nerd-fonts.caskaydia-cove

        montserrat
        garamond-libre
        merriweather
      ];
    };

  flake.homeModules.basePackages =
    {
      self,
      pkgs,
      inputs,
      lib,
      ...
    }:
    {
      imports = [
        self.homeModules.direnvModule
        self.homeModules.musicModule
        self.homeModules.nvfModule
        self.homeModules.neovideModule
        self.homeModules.mpvModule
      ]
      # Load browser
      ++ lib.optional (globalSettings.browser == "helium") self.homeModules.heliumBrowserModule
      ++ lib.optional (globalSettings.browser == "zen") self.homeModules.zenBrowserModule;

      home.packages = with pkgs; [
        google-chrome
        lazygit
        wl-gammactl
        imagemagick
        inotify-tools
        libnotify
        cava

        qimgv
        darktable

        vim
        neovim
        ollama
        localsend
        vscode
        obsidian

        libreoffice
        calibre

        easyeffects
        strawberry
        lrcget

        bottles
        discord

        obs-studio
        davinci-resolve
      ];
    };
}
