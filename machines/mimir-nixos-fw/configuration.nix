{ config, pkgs, ... }:

let
  modulesBase = "/home/mimir/dotfiles/modules";
in
{
  system.stateVersion = "21.05";

  imports = [
    ./hardware-configuration.nix
  ] ++ map (path: modulesBase + ("/" + path)) [
    "desktop.nix"

    "audio.nix"
    "tailscale.nix"
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  nixpkgs.config.allowUnfree = true;

  nixpkgs.config.pulseaudio = true;

  networking.networkmanager.enable = true;

  networking.hostName = "mimir-nixos-fw"; # Define your hostname.

  time.timeZone = "America/Los_Angeles";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;

  users.mutableUsers = false;
  users.users.mimir = {
    isNormalUser = true;
    description = "Mimir";

    extraGroups = [ "audio" "jackaudio" "wheel" "networkmanager" ];

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
  services.thermald.enable = true;
  services.fprintd.enable = false;

  services.pcscd.enable = true;
  services.yubikey-agent.enable = true;

  security.sudo.wheelNeedsPassword = false;

  security.pam.services.login.fprintAuth = true;
  security.pam.services.kde.fprintAuth = true;
  security.pam.services.sddm.fprintAuth = false;
  security.pam.services.gdm.fprintAuth = true;

  hardware.cpu.intel.updateMicrocode = true;
  hardware.enableAllFirmware = true;

  boot.kernelParams = [
    "i915.enable_fbc=1"
    "i915.enable_psr=2"
    "i915.enable_guc=2"
  ];

  fileSystems."/".options = [ "noatime" "nodiratime" "discard=async" "compress" ];
}

