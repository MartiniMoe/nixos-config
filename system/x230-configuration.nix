{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [
    /etc/nixos/hardware-configuration.nix
    <nixos-hardware/lenovo/thinkpad/x230>
    <nixos-hardware/common/pc/ssd>
  ];

  # Networking
  networking.interfaces.enp0s25.useDHCP = true;
  networking.interfaces.wlp3s0.useDHCP = true;
  networking.hostName = "galactica";
  
  # x230 Display Mod Workaround
  systemd.tmpfiles.rules = [
    "L+ /run/gdm/.config/monitors.xml - - - - ${./x230-monitors.xml}"
  ];
}
