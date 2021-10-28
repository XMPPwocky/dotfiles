{ config, pkgs, ... }:
{
  home.packages = [
    (pkgs.renoise.override { releasePath = /home/mimir/renoise/rns_332_linux_x86_64.tar.gz; })
  ];
}
