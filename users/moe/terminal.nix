{ config, pkgs, lib, ... }:

{
  # Terminal / Shell
  programs.bash.enable = true;
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    enableSyntaxHighlighting = true;
    history = {
      share = false;
    };
    prezto = {
      enable = true;
      pmodules = [
        "completion"
      ];
    };
  };

  # Prompt
  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    settings = {
      add_newline = false;
      line_break = {
        disabled = true;
      };
    };
  };

  # Commandline Tools
  programs.htop.enable = true;
  programs.bat.enable = true;
  programs.exa.enable = true;
  programs.zsh.shellAliases = {
    ls = "exa --icons --group-directories-first";
    ll = "exa -l --icons --group-directories-first";
    cat = "bat";
    gst = "git status";
    docker-compose = "podman-compose";
  };
}
