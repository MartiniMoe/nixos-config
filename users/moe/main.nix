{ config, pkgs, lib, ... }:

{
  imports = [
    ./gnome.nix
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

  # Terminal / Shell
  programs.bash.enable = true;
  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "man" ];
    };
    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
    ];
    initExtra = "source ~/.p10k.zsh";
  };
  home.file = {
    ".p10k.zsh".source = ./p10k-config;
  };

  # Commandline Tools
  programs.htop.enable = true;
  programs.bat.enable = true;
  programs.exa.enable = true;
  programs.zsh.shellAliases = {
    ls = "exa --icons --group-directories-first";
    ll = "exa -l --icons --group-directories-first";
    cat = "bat";
  };

  # Chromium
  programs.chromium.enable = true;

  # Firefox
  programs.firefox = {
    enable = true;
    profiles.moe = {
      isDefault = true;
      settings = {
        "app.normandy.first_run" = false;
        "app.shield.optoutstudies.enabled" = false;
        "browser.startup.homepage" = "https://duckduckgo.com";
        "browser.tabs.loadInBackground" = true;
        "browser.urlbar.placeholderName" = "DuckDuckGo";
        "browser.uidensity" = 1;
        "browser.search.regior" = "DE";
        "general.useragent.locale" = "de-DE";
        "distribution.searchplugins.defaultLocale" = "de-DE";
        "privacy.donotttrackheader.enabled" = true;
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
    includes = [
      {
        contents = {
          user.name = "Moritz Obermann";
          user.email = "moritz.obermann@fnordkollektiv.de";
          signing = {
            key = "BE70DB970BE7D022";
            signByDefault = true;
          };
        };
        condition = "gitdir:~/git/coop";
      }
      {
        contents = {
          user.name = "MartiniMoe";
          user.email = "moe@martini.moe";
          signing.key = "C78F3B6A153F2B84BDD9440248C1E7C34A019089";
          signing.signByDefault = true;
        };
        condition = "gitdir:~/git/hasi";
      }
      {
        contents = {
          user.name = "MartiniMoe";
          user.email = "martini.moe@cheex.de";
          signing.key = "71B0B590034C49C110111D2C97958F7E867A9CF7";
          signing.signByDefault = true;
        };
        condition = "gitdir:~/git/github";
      }
      {
        contents = {
          user.name = "MartiniMoe";
          user.email = "martini.moe@cheex.de";
        };
        condition = "gitdir:~/git/gitlab";
      }
    ];
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