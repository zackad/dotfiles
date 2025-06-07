# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Kernel version
  boot.kernelPackages = pkgs.linuxKernel.packages.linux_zen;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Cleaup /tmp directory on boot
  boot.tmp.cleanOnBoot = true;

  # Appimage interpreter
  boot.binfmt.registrations.appimage = {
    wrapInterpreterInShell = false;
    interpreter = "${pkgs.appimage-run}/bin/appimage-run";
    recognitionType = "magic";
    offset = 0;
    mask = "\\xff\\xff\\xff\\xff\\x00\\x00\\x00\\x00\\xff\\xff\\xff";
    magicOrExtension = "\\x7fELF....AI\\x02";
  };

  # Enable ntfs support at boot
  # boot.supportedFilesystems = [ "ntfs" ];

  networking.hostName = "NixOS"; # Define your hostname.

  # Wake on LAN
  networking.interfaces.enp9s0.wakeOnLan = {
    enable = true;
    policy = [ "magic" ];
  };
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Enable tailscale network
  services.tailscale.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Jakarta";
  time.hardwareClockInLocalTime = true;

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

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the XFCE Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.theme = "chili";
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "zackad";
  services.xserver.desktopManager.xfce.enable = true;

  # Configure keymap in X11
  services.xserver = {
    xkb.layout = "us";
    xkb.variant = "";
  };

  # Load nvidia driver for Xorg
  services.xserver.videoDrivers = [ "nvidia" ];
  boot.initrd.kernelModules = [ "nvidia" ];
  boot.blacklistedKernelModules = [ "nouveau" ];

  hardware.nvidia = {
    # Modesetting is required.
    modesetting.enable = true;

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    powerManagement.enable = true;

    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = false;

    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures. Full list of
    # supported GPUs is at:
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus
    # Only available from driver 515.43.04+
    # Do not disable this unless your GPU is unsupported or if you have a good reason to.
    open = true;

    # Enable the Nvidia settings menu,
    # accessible via `nvidia-settings`.
    nvidiaSettings = false;

    # Whether to enable forcefully the full composition pipeline. This sometimes fixes
    # screen tearing issues. This has been reported to reduce the performance of some OpenGL
    # applications and may produce issues in WebGL. It also drastically increases the time
    # the driver needs to clock down after load.
    # I need this to fix screen tearing after using i3 as window manager
    forceFullCompositionPipeline = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
  hardware.nvidia-container-toolkit.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = false;

  # Bluetooth configuration
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # Enable sound with pulseaudio.
  services.pulseaudio.enable = true;
  services.pulseaudio.support32Bit = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = false;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Enable flatpak package manager
  services.flatpak.enable = true;
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  programs.zsh.enable = true;

  # Uncomment following line to enable steam
  programs.steam.enable = true;
  programs.steam.remotePlay.openFirewall = true;

  # services.gnome.gnome-keyring.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.zackad = {
    isNormalUser = true;
    description = "zackad";
    extraGroups = [
      "audio"
      "networkmanager"
      "wheel"
    ];
    shell = pkgs.zsh;
    packages = with pkgs; [ ];
  };

  virtualisation.docker = {
    enable = true;
    rootless.enable = true;
    rootless.setSocketVariable = true;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    cifs-utils
    dmenu
    i3
    i3status
    lightlocker
    sddm-chili-theme
    tailscale
    xarchiver
    xfce.thunar-archive-plugin
    xfce.xfce4-pulseaudio-plugin
    xfce.xfce4-volumed-pulse
    xfce.xfce4-weather-plugin
    zip
    #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    #  wget
  ];

  # Mount samba share
  fileSystems."/Volumes/samba" = {
    device = "//192.168.88.2/main";
    fsType = "cifs";
    # TODO: save credentials using secret manager
    options = [
      "credentials=/etc/nixos/smb-secrets"
      "uid=1000"
      "gid=100"
    ];
  };

  fileSystems."/Volumes/backup" = {
    device = "//192.168.88.2/backup";
    fsType = "cifs";
    # TODO: save credentials using secret manager
    options = [
      "credentials=/etc/nixos/smb-secrets"
      "uid=1000"
      "gid=100"
    ];
  };

  fileSystems."/Volumes/sata-ssd" = {
    device = "/dev/disk/by-uuid/3f3d53dd-5d61-4932-b226-48f838ce8807";
    fsType = "ext4";
  };

  fileSystems."/Volumes/data" = {
    device = "/dev/disk/by-uuid/14AE1D30AE1D0C3C";
    fsType = "ntfs";
    options = [
      "rw"
      "uid=1000"
      "gid=100"
    ];
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
  services.openssh.enable = true;

  # Enable syncthing service
  services.syncthing = {
    enable = true;
    user = "zackad";
    dataDir = "/home/zackad/Samba/SavedGames";
    configDir = "/home/zackad/Samba/SavedGames/.config/syncthing";
  };
  systemd.services.syncthing = {
    after = [ "Volumes-samba.mount" ];
    requires = [ "Volumes-samba.mount" ];
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
  nix.settings.allowed-users = [
    "@wheel"
    "@builders"
    "zackad"
  ];
  nix.settings.trusted-users = [
    "root"
    "zackad"
  ];
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
}
