# Diz Config

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./appconfig.nix
    ];
  
  # Enable flakes and that
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Boot stuff
  boot = {
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

  # Virtualisation settings
  virtualisation.libvirtd.enable = true; 
 
  system.stateVersion = "26.05"; # Did you read the comment? No 
}
