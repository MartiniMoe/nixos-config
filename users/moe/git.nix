{ config, pkgs, lib, ... }:

{
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
}
