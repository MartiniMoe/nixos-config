{ config, pkgs, lib, ... }:

{
  # NeoVIM
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    extraConfig = ''
      set clipboard=unnamedplus
      set tabstop=4
      set shiftwidth=4
      set expandtab
      set mouse=r
      set number relativenumber
      '';
  };
}
