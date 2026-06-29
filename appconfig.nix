{ config, pkgs, ... }:

{
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
}
