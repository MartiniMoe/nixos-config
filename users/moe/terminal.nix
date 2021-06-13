{ config, pkgs, lib, ... }:

{
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
}
