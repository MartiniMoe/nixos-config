{ config, pkgs, ... }:

{
  imports = [
    ./x230-configuration.nix
  ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Networking
  networking.useDHCP = false;

  # Internationalization
  time.timeZone = "Europe/Berlin";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.supportedLocales = [
    "en_US.UTF-8/UTF-8"
    "de_DE.UTF-8/UTF-8"
  ];
  i18n.extraLocaleSettings = {
    LC_NUMERIC="de_DE.UTF-8";
    LC_TIME="de_DE.UTF-8";
    LC_MONETARY="de_DE.UTF-8";
    LC_PAPER="de_DE.UTF-8";
    LC_MEASUREMENT="de_DE.UTF-8";
  };
  console.useXkbConfig = true;

  # Desktop Environment
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.layout = "de";
  services.xserver.xkbVariant = "neo";

  # Printing
  services.printing.enable = true;
  services.printing.drivers = [ pkgs.hplip ];

  # Sound
  hardware.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Users
  programs.zsh.enable = true;
  #users.defaultUserShell = pkgs.zsh;
  #users.mutableUsers = false;
  users.users.moe = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    hashedPassword = "$6$diHSunVCS8rpWzZP$EK6eatrlDUogE.Gk3az8zcebb.1gne2qiXbEtpX3VEVIdtkWvW2C8YL6IrCLSSbllGHhXRnCqeFfQTr4RE./F/";
    shell = pkgs.zsh;
  };

  # System Packages
  environment.systemPackages = with pkgs; [
    wget
    mkpasswd
    ranger
    git
    gnupg
    vim
  ];

  # Maintenance settings
  system.autoUpgrade.enable = true;
  nix.gc.automatic = true;
  
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.09"; # Did you read the comment?

}
