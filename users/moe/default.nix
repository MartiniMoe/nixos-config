{ config, pkgs, lib, ... }:

{
  imports = [
    ./gnome.nix
    ./terminal.nix
    ./vim.nix
    ./git.nix
    ./ssh.nix
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
    element-desktop
    transmission

    python3Minimal
    gopass
    ansible
    upterm
    nvd

    nerdfonts
    noto-fonts
    noto-fonts-extra
    noto-fonts-emoji

    blender
    krita
    glimpse
    graphviz # needed by glimpse...
    inkscape
    godot
    godot-export-templates
    vlc
    ungoogled-chromium

    libreoffice-fresh
    nextcloud-client
  ];
  
  # GPG
  programs.gpg.enable = true;
  services.gpg-agent = {
    enable = true;
    pinentryFlavor = "gnome3";
  };

  # Session Variables
  home.sessionVariables = {
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
