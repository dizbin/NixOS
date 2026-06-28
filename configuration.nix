# Diz Config

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Boot and Kernel stuff
  boot = {
    # Boot newest kernel version available
    kernelPackages = pkgs.linuxPackages_latest;
    # Load modules 
    kernelModules = [ ];
    # Kernel parameters
    kernelParams = [ "quiet" ];
    
    plymouth.enable = true; 
    loader = { 
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  networking = { 
    hostName = "Cerberus"; # Define your hostname.
    networkmanager.enable = true;
  }; 

  # Timezone / Locale 
  time.timeZone = "America/Mexico_City";
  i18n.defaultLocale = "es_ES.UTF-8";

  # Service descriptions 
  services = {
    # Gotta have that Goooey
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };
    desktopManager.plasma6.enable = true;
    
    # We use Wayland up in here 
    xserver.enable = false;

    # Disable printing
    printing.enable = false;

    # Pipewire 
    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true; 
    };  
  }; 

  security.rtkit.enable = true;

  # Define a user account. 
  users.users."dizbin" = {
    isNormalUser = true;
    description = "Diz Bin";
    extraGroups = [ "networkmanager" "wheel" "users" "video" "audio" ];
    packages = with pkgs; [
    ];
  };

  # Install firefox.
  programs = { 
    firefox.enable = true;

    steam = {
      enable = true;
      remotePlay.openFirewall = true; 
      dedicatedServer.openFirewall = true; 
      localNetworkGameTransfers.openFirewall = true; 
    };
  };

  # Nixpkg configs 
  nixpkgs = {
    # Allow all the things
    config.allowUnfree = true;
    config.allowBroken = true;
  };

  # System packages 
  environment.systemPackages = with pkgs; [
    # Term stuff
    vim 
    wget
    git
    gamemode
    mangohud
    btop-rocm 
    qemu 
    fastfetch 
 
    # AI related shit
    rocmPackages.rocm-smi
    rocmPackages.hip-common
    rocmPackages.hipcc
    rocmPackages.hipblas-common
    ollama-rocm
    
    # Gooey stuff
    kitty
    transmission_4-qt6
    vscodium
    spotify
    vesktop
    gimp
    mangojuice
    onlyoffice-desktopeditors
    gpu-screen-recorder-gtk
    virt-manager
    heroic-unwrapped
    vlc
  ];
  
  # Exclude plasma shit
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    elisa
    discover
    kate
    khelpcenter
    konsole
    oxygen
    qrca
    kwalletmanager
    plasma-systemmonitor
  ];
  
  # Virtualisation settings
  virtualisation.libvirtd.enable = true; 
 
  system.stateVersion = "26.05"; # Did you read the comment? No 
}
