{ config, pkgs, lib, ... }:

{
  # NeoVIM
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    extraConfig = ''
      syntax on
      set title
      set clipboard=unnamedplus
      set tabstop=4
      set shiftwidth=4
      set expandtab
      set mouse=r
      set number relativenumber
      set nocompatible
      call neomake#configure#automake('nrwi', 500)
      '';
    plugins = with pkgs.vimPlugins; [
      vim-nix
      neomake
    ];
    extraPackages = with pkgs; [
      yamllint
    ];
  };

  # Session Variables
  home.sessionVariables = {
    EDITOR = "vim";
    VISUAL = "vim";
  };
}
