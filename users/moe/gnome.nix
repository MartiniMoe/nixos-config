{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    gnome.gnome-tweak-tool
    gnome.gnome-boxes
    gnome.dconf-editor
    gnome.meld
    gnomeExtensions.caffeine
    gnomeExtensions.gsconnect
  ];

  # DCONF Settings
  dconf.settings = {
    "org/gnome/shell" = {
      "disabled-extensions" = [];
      "enabled-extensions" = [
        "caffeine@patapon.info"
        "gsconnect@andyholmes.github.io"
      ];
    };
    "org/gnome/settings-daemon/plugins/color" = {
      "night-light-enabled" = true;
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      "binding" = "<Super>Return";
      "command" = "gnome-terminal";
      "name" = "Terminal";
    };
    "org/gnome/desktop/input-sources" = {
      "current" = "uint32 0";
      "sources" = [
        (lib.hm.gvariant.mkTuple [ "xkb" "de+neo" ])
        (lib.hm.gvariant.mkTuple [ "xkb" "de+nodeadkeys" ])
      ];
    };
    "org/gnome/desktop/wm/keybindings" = {
      "switch-applications" = [ ];
      "switch-applications-backward" = [ ];
      "switch-windows" = [ "<Alt>Tab" ];
      "switch-windows-backward" = [ "<Shift><Alt>Tab" ];
    };
    "org/gnome/gedit/preferences/editor" = {
      "tabs-size" = "uint32 4";
      "insert-spaces" = true;
      "scheme" = "solarized-dark";
    };
    "org/gtk/settings/file-chooser" = {
      "sort-directories-first" = true;
    };
  };

  programs.gnome-terminal = {
    enable = true;
    showMenubar = false;
    themeVariant = "dark";
    profile = {
      "b1dcc9dd-5262-4d8d-a863-c897e6d979b9" = {
        visibleName = "moe";
        default = true;
        audibleBell = false;
        showScrollbar = false;
      };
    };
  };
}
