{ lib, config, pkgs, ... }:

let
  modulesBase = "/home/mimir/dotfiles/modules";
in
{
  system.stateVersion = "21.05";

  imports = [
    ./hardware-configuration.nix
  ] ++ map (path: modulesBase + ("/" + path)) [
    "basic-users.nix"
    "desktop.nix"

    "audio.nix"
    "tailscale.nix"
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  nixpkgs.config.allowUnfree = true;

  networking.networkmanager.enable = true;

  networking.hostName = "mimir-nixos-fw"; # Define your hostname.

  time.timeZone = "America/Los_Angeles";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;

  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [
    53735 # resilio (non-default)
  ];
  networking.firewall.allowedUDPPorts = [
    53735 # resilio (non-default)
  ];

  programs.steam.enable = true;

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
  services.fwupd.enable = true;
  services.ratbagd.enable = true;

  security.sudo.wheelNeedsPassword = false;

  hardware.cpu.intel.updateMicrocode = true;
  hardware.enableAllFirmware = true;

  boot.kernelParams = [
    "i915.enable_fbc=1"
    "i915.enable_psr=2"
    "i915.enable_guc=2"
  ];
  boot.extraModprobeConfig = lib.mkMerge [
    "options iwlwifi power_save=1 swcrypto=1"
  ];

  services.tlp = {
    enable = true;
  };

  fileSystems."/".options = [ "relatime" "nodiratime" "discard=async" "compress" ];
}

