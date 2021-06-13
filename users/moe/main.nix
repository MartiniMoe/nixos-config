{ config, pkgs, lib, ... }:

{
  imports = [
    ./gnome.nix
    ./terminal.nix
    ./vim.nix
    ./git.nix
    ./firefox.nix
  ];

  # Home-Manager
  programs.home-manager.enable = true;
  home.username = "moe";
  home.homeDirectory = "/home/moe";
  news.display = "silent";

  # User Packages
  home.packages = with pkgs; [
    discord
    tdesktop
    signal-desktop
    transmission

    python3Minimal
    gopass
    ansible

    zsh-powerlevel10k         # ZSH theme
    meslo-lgs-nf              # Patched Nerd Fonts for ZSH theme
    nerdfonts
    noto-fonts
    noto-fonts-extra
    noto-fonts-emoji

    blender
    krita
    gimp
    inkscape
    godot
    godot-export-templates
    vlc

    libreoffice-fresh
    nextcloud-client
  ];

  # Chromium
  programs.chromium.enable = true;
  
  # SSH
  programs.ssh.enable = true;
  programs.ssh.matchBlocks = {
    "eris" = {
      hostname = "5.9.109.132";
      user = "root";
      port = 22022;
      localForwards = [
        {
          bind.port = 8006;
          host.address = "5.9.109.132";
          host.port = 8006;
        }
      ];
    };
    "eris-nginx" = {
      hostname = "10.57.1.1";
      user = "root";
    };
  };

  # GPG
  programs.gpg.enable = true;
  services.gpg-agent = {
    enable = true;
    pinentryFlavor = "gnome3";
  };

  # Session Variables
  home.sessionVariables = {
    MOZ_ENABLE_WAYLAND = 1;
    EDITOR = "vim";
    QT_QPA_PLATFORM = "wayland";
  };

  # x230 Display Mod Workaround
  home.file = {
    ".config/monitors.xml".source = ../../system/x230-monitors.xml;
  };

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.05";
}
