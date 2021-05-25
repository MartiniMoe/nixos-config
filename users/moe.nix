{ config, pkgs, lib, ... }:

{
  # Home-Manager
  programs.home-manager.enable = true;
  home.username = "moe";
  home.homeDirectory = "/home/moe";
  news.display = "silent";

  # User Packages
  home.packages = with pkgs; [
    gnome.gnome-tweak-tool
    gnome.gnome-boxes
    gnome.dconf-editor
    gnome.meld
    gnomeExtensions.caffeine
    
    discord
    tdesktop
    signal-desktop
    transmission

    python3Minimal
    git-crypt
    pass
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

    libreoffice-fresh
    nextcloud-client
  ];

  # DCONF Settings
  dconf.settings = {
    "org/gnome/settings-daemon/plugins/color" = {
      "night-light-enabled" = true;
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

  # Terminal / Shell
  programs.bash.enable = true;
  programs.zsh.enable = true;
  programs.zsh.oh-my-zsh = {
    enable = true;
    plugins = [ "git" "man" "pass" ];
  };
  programs.zsh.plugins = [
    {
      name = "powerlevel10k";
      src = pkgs.zsh-powerlevel10k;
      file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
    }
  ];
  home.file = {
    ".p10k.zsh".source = ./p10k-config;
  };
  programs.zsh.initExtra = "source ~/.p10k.zsh";
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

  #Chromium
  programs.chromium.enable = true;

  # Firefox
  programs.firefox = {
    enable = true;
    #package = pkgs.firefox-wayland;
    package = pkgs.wrapFirefox pkgs.firefox-unwrapped {
      forceWayland = true;
      extraPolicies = {
        ExtensionSettings = {};
      };
    };
    profiles.moe = {
      isDefault = true;
      settings = {
        "app.normandy.first_run" = false;
        "app.shield.optoutstudies.enabled" = false;
        "browser.startup.homepage" = "https://duckduckgo.com";
        "browser.tabs.loadInBackground" = true;
        "browser.urlbar.placeholderName" = "DuckDuckGo";
        "browser.search.regior" = "DE";
        "general.useragent.locale" = "de-DE";
        "distribution.searchplugins.defaultLocale" = "de-DE";
        "privacy.donotttrackheader.enabled" = true;
        # Following kills receiving jitsi video streams?
         "media.ffmpeg.vaapi.enabled" = true;
         "media.ffvpx.enabled" = false;
         "media.rdd-vpx.enabled" = false;
         "media.navigator.mediadatadecoder_vpx_enabled" = true;
      };
    };
  };
  
  # VIM
  programs.vim = {
    enable = true;
    settings = {
      tabstop = 4;
      shiftwidth = 4;
      expandtab = true;
      mouse = "r";
      number = true;
      relativenumber = true;
    };
    extraConfig = ''
      set clipboard=unnamedplus
      '';
  };

  # GIT
  programs.git = {
    enable = true;
    userName = "MartiniMoe";
    userEmail = "martini.moe@cheex.de";
    aliases = {
      alias = "!git config --get-regexp alias | sed 's/alias\\.\\([^ ]*\\) /\\1 := /'";
      graph = "log --graph --decorate --oneline";
      map = "!git graph --all";
      watch = "!watch -ct 'git -c color.status=always status -s && echo && git map --color'";
    };
    extraConfig = {
      pull.rebase = false;
      merge.tool = "meld";
      rebase.autosquash = true;
      init.defaultBranch = "main";
    };
  };

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
    ".config/monitors.xml".source = ../system/x230-monitors.xml;
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
