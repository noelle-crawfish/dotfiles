
# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:
{
  imports =
    [ 
	# Include the results of the hardware scan.
      	./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "mycotoxin"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  security.pki.certificateFiles = [ "${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt" ];

  # Environment variables for SSL/TLS certificates
  environment.sessionVariables = {
    SSL_CERT_FILE = "${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt";
    NIX_SSL_CERT_FILE = "${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt";
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  boot.kernelModules = [ "snd-hda-intel" ];
  boot.extraModprobeConfig = ''
    options snd-hda-intel power_save=0
  '';

# Enable docker
virtualisation.docker.enable = true;


# libvirtd
virtualisation.libvirtd = {
  enable = true;
  qemu = {
    package = pkgs.qemu_kvm;
    runAsRoot = true;
    swtpm.enable = true;
    ovmf = {
      enable = true;
      packages = [(pkgs.OVMF.override {
        secureBoot = true;
        tpmSupport = true;
      }).fd];
    };
  };
};


  # Set your time zone.
  time.timeZone = "America/Chicago";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

# i18n.inputMethod = {
#      enabled = "fcitx5";
#      fcitx5.waylandFrontend = true;
#      fcitx5.addons = with pkgs; [
#        fcitx5-gtk             # alternatively, kdePackages.fcitx5-qt
#        fcitx5-chinese-addons  # table input method support
#        fcitx5-nord            # a color theme
#      ];
#    };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # xdg
  services.xserver.desktopManager.runXdgAutostartIfNone = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true; # TODO maybe change to lightdm

  programs.hyprland.enable = true;
  programs.niri.enable = true;


  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  # hardware.pulseaudio.enable = false;
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    # media-session.enable = true;
    wireplumber.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  programs.zsh.enable = true;

nix.settings.trusted-users = [ "root" "noelle" ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.noelle = {
    isNormalUser = true;
    description = "Noelle Crawford";
    extraGroups = [ "networkmanager" "wheel" "docker" "libvirtd" "audio" "dialout" ];
	  shell = pkgs.zsh;
  };

security.sudo.wheelNeedsPassword = false;


  # Install firefox.
  programs.firefox.enable = true;

# services.bitlbee = {
#   enable = true;
#   plugins = [
#     pkgs.bitlbee-discord
#     pkgs.bitlbee-facebook
#     # all plugins: `nix-env -qaP | grep bitlbee-`
#   ];
# };


  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  	vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
	  emacs
	  git
  	wget
	  cmake
	  gnumake
	  libgcc
	  gcc
	  libtool
	  hyprpaper
	  hyprshot
	  wofi
	  fd
	  ripgrep
	  feh
	  htop
	  go
    
	  python3
    
	  alsa-utils
	  brightnessctl
    
	  gdb
	  ags
	  autoconf
	  automake
	  zlib
	  sassc
	  openjdk
	  gjs
	  nodejs
    
	  openssl
    
	  virt-manager
	  virt-viewer
	  qemu
    
	  cargo
	  sshpass
    
	  openconnect
    
	  kitty
	  zip
    
	  sqlitebrowser
    
	  delta
    
	  verilator
	  xorg.xkill
	  llvm
	  clang
	  botan3
	  pkg-config

	  cloc

    signal-cli
    cacert

    fuzzel

    xwayland-satellite
  ];


fonts.packages = with pkgs; [
  # nerdfonts
  source-code-pro
];

# https://github.com/NixOS/nixpkgs/issues/306446 -> solve for ags system tray
  nixpkgs.overlays = [
    (final: prev:
    {
      ags = prev.ags.overrideAttrs (old: {
        buildInputs = old.buildInputs ++ [ pkgs.libdbusmenu-gtk3 ];
      });
    })
  ];

  # steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };

  hardware.opengl = {
    enable = true;
    # driSupport = true;
    driSupport32Bit = true;
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
