{ config, pkgs, lib, ... }:

{
  # Terminal / Shell
  programs.bash.enable = true;
  programs.zsh = {
    enable = true;
    prezto = {
      enable = true;
      prompt.theme = "skwp";
      pmodules = [
        "environment"
        "terminal"
        "editor"
        "history"
        "directory"
        "spectrum"
        "utility"
        "completion"
        "prompt"
        "git"
      ];
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
  };
}
