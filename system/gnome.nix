{ config, pkgs, ... }:

{
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  environment.systemPackages = with pkgs; [
    gnomeExtensions.gsconnect # Somehow this has to be a system package...
  ];

  # Ports for KDE connect. Will soon be fixed by using programs.kdeconnect.enable
  # and programs.kdeconnect.package = gnomeExtensions.gsconnect
  # See https://github.com/NixOS/nixpkgs/issues/116388
  networking.firewall.allowedTCPPortRanges = [
    { from = 1714; to = 1764; }
  ];
  networking.firewall.allowedUDPPortRanges = [
    { from = 1714; to = 1764; }
  ];
}
