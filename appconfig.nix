{ config, pkgs, ... }:

{
  # Fucking shit all up ovahea 
  nixpkgs.config.permittedInsecurePackages = [
    "pnpm-10.29.2"
    "electron-40.10.5"    
  ];
  
  # Install firefox.
  programs = { 
    firefox.enable = true;
    
    gamemode = { 
      enable = true; 
      enableRenice = true;
    };
    
    steam = {
      enable = true;
      remotePlay.openFirewall = true; 
      dedicatedServer.openFirewall = true; 
      localNetworkGameTransfers.openFirewall = true; 
    };
  
    vim = { 
      enable = true;
      defaultEditor = true; 
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
    wget
    git
    mangohud
    btop-rocm 
    qemu 
    fastfetch 
    python314
    distrobox 
    unzip
    usbutils 
    e2fsprogs
    rust-analyzer-unwrapped
 
    # AI related shit
    rocmPackages.rocm-smi
    rocmPackages.hip-common
    rocmPackages.hipcc
    rocmPackages.hipblas-common
    ollama-rocm
    
    # Gooey stuff
    kitty
    transmission_4-qt
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
    kdePackages.kcalc
  ];
  
  # Exclude plasma shit
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    elisa
    discover
    kate
    khelpcenter
    konsole
    qrca
    kwalletmanager
    plasma-systemmonitor
    kwin-x11
  ];
}
