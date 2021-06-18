{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [
    /etc/nixos/hardware-configuration.nix
  ];

  powerManagement.enable = true;
  powerManagement.cpuFreqGovernor = "performance";
  
  # Networking
  networking.interfaces.enp0s25.useDHCP = true;
  networking.interfaces.wlp3s0.useDHCP = true;
  networking.hostName = "galactica";
  
  # Video
  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      vaapiIntel
      vaapiVdpau
      libvdpau-va-gl
    ];
  };

  # Microcode updates
  hardware.cpu.intel.updateMicrocode = true;
  
  # x230 Display Mod Workaround
  systemd.tmpfiles.rules = [
    "L+ /run/gdm/.config/monitors.xml - - - - ${./x230-monitors.xml}"
  ];
}
