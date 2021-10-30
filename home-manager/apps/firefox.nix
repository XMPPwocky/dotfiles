{ config, pkgs, ... }:
{
  programs.firefox.enable = true;
  programs.firefox.package = pkgs.firefox.override {
    forceWayland = true;
  };
}
