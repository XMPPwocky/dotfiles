{ config, pkgs, ... }:

let
  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
in
{
  imports = [
  	./chromium.nix
  ];

  programs.home-manager.enable = true;

  home.username = "mimir";
  home.homeDirectory = "/home/mimir";

  home.stateVersion = "21.05";

  nixpkgs.config = {
	  allowUnfree = true;
  };

  home.packages = with pkgs; [
    neovim
    discord
    ripgrep
    alacritty
    tdesktop

    unstable.bitwig-studio4
  ];

  programs.bash.enable = true;
  programs.git = {
    enable = true;
    userName = "Mimir";
    userEmail = "mimir@xmppwocky.net";
  };
}
