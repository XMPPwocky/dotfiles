{ config, pkgs, ... }:

{
  system.stateVersion = "21.05";

  imports =
    [
      ./hardware-configuration.nix

      ./tlp.nix
      ./tailscale.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  hardware.pulseaudio.enable = true;

  nixpkgs.config.allowUnfree = true;

  nixpkgs.config.pulseaudio = true;

  networking.networkmanager.enable = true;

  networking.hostName = "mimir-nixos-fw"; # Define your hostname.

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;

  services.xserver.enable = true;

  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;
  #services.xserver.desktopManager.plasma5.runUsingSystemd = true;
  services.xserver.displayManager.sessionPackages = [
  	(pkgs.plasma-workspace.overrideAttrs
		(old: { passthru.providedSessions = ["plasmawayland"]; }))
		];
  

  security.sudo.wheelNeedsPassword = false;
  users.mutableUsers = false;
  users.users.mimir = {
    isNormalUser = true;
    description = "Mimir";

    extraGroups = [ "audio" "wheel" "networkmanager" ]; 

    hashedPassword = (builtins.readFile /etc/nixos/mimir_pwhash);
  };

  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [
    53735 # resilio (non-default)
  ];
  networking.firewall.allowedUDPPorts = [
    53735 # resilio (non-default)
  ];

  programs.steam.enable = true;

  #networking.extraHosts = ''149.56.47.63	downloads-NA.bitwig.com'';

  hardware.opengl = {
    enable = true;
    extraPackages = [ pkgs.vaapiIntel ];
    driSupport32Bit = true;
  };
  nixpkgs.config.packageOverrides = pkgs: {
    vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
  };

  services.cpupower-gui.enable = true;
  services.pcscd.enable = true;
  services.yubikey-agent.enable = true;
}
