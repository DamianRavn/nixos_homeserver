# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs,user, hostname, version, ... }:

{

  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Bootloader configuration
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

nix = {
    # Enable flakes!
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
    };
  };

  # Networking configuration
  networking = 
  {
    hostName = "${hostname}";
    networkmanager.enable = true;
    enableIPv6 = false;
    firewall = {
      enable = true;
      # Uncomment and specify if you need to allow certain ports:
      # allowedTCPPorts = [ 22 ];
      # allowedUDPPorts = [ ... ];
    };
    defaultGateway =
    {
      address = "192.168.87.1";
      interface = "wlp5s0";
    };
interfaces =
{
  wlp5s0.ipv4.addresses = 
  [{
address = "192.168.87.146";
prefixLength = 24;
  }];
};
  };


    # Disable PulseAudio to use PipeWire instead
    hardware.pulseaudio.enable = false;
    security.rtkit.enable = true;

  # Service configuration
  services = {

  # SSH service
  openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = true;
      AllowedUsers = null;
      UseDns = true;
      PermitRootLogin = "prohibit-password";
    };
    };
    # Enable X11 and GNOME
    xserver = {
      enable = true;
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
      xkb = {
        layout = "dk";
        variant = "";
      };
    };
    
    # Auto login for user
    displayManager.autoLogin = {
      enable = true;
      user = "${user}";
    };

    # PipeWire sound system
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
      # Uncomment if you want to use JACK applications
      # jack.enable = true;
    };


    # Laptop settings
    logind = {
      lidSwitch = "ignore";
      lidSwitchDocked = "ignore";
      lidSwitchExternalPower = "ignore";
    };
  };

  # Docker configuration
  virtualisation.docker.enable = true;

  # Time zone and internationalization
  time.timeZone = "Europe/Copenhagen";
  i18n = {
    defaultLocale = "en_DK.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "da_DK.UTF-8";
      LC_IDENTIFICATION = "da_DK.UTF-8";
      LC_MEASUREMENT = "da_DK.UTF-8";
      LC_MONETARY = "da_DK.UTF-8";
      LC_NAME = "da_DK.UTF-8";
      LC_NUMERIC = "da_DK.UTF-8";
      LC_PAPER = "da_DK.UTF-8";
      LC_TELEPHONE = "da_DK.UTF-8";
      LC_TIME = "da_DK.UTF-8";
    };
  };

  # Keyboard configuration
  console.keyMap = "dk-latin1";

  # User configuration
  users.users.${user}= {
    isNormalUser = true;
    description = "Dragonalias";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    home = "/home/${user}";
    shell = pkgs.fish;
  };

  # Enable programs
  programs = {
    firefox.enable = true;
    fish.enable = true;

    nh = {
      enable = true;
      flake = "/home/${user}/.dotfiles";
    };
  };

  environment = {
    variables = {
      EDITOR = "hx";
      SYSTEMD_EDITOR = "hx";
      VISUAL = "hx";
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

    # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value, read the documentation for this option
  # (e.g., man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "${version}"; # Did you read the comment? 

  # List packages installed in the system profile
  environment.systemPackages = with pkgs; [
    xclip
    copyq
    helix
    docker_27
    alacritty
    fzf 
    neofetch
    zoxide
    tealdeer
    git
    lazygit
    atuin
    dust
  ];
}
