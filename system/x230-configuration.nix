{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ehci_pci" "ahci" "usb_storage" "sd_mod" "sdhci_pci" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/mapper/NIXENC";
      fsType = "btrfs";
    };

  boot.initrd.luks.devices."NIXENC".device = "/dev/disk/by-uuid/cbefff03-95af-417e-99ef-13fdf80141a4";

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/D313-5306";
      fsType = "vfat";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/cbe261e7-0c5b-4f14-b052-173bcbadefc3"; }
    ];

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  powerManagement.enable = true;
  
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
  
  # x230 Display Mod Workaround
  systemd.tmpfiles.rules = [
    "L+ /run/gdm/.config/monitors.xml - - - - ${./x230-monitors.xml}"
  ];
}
