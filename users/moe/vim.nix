{ config, pkgs, lib, ... }:

{
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
}
