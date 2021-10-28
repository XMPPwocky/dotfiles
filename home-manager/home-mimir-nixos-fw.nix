{ config, pkgs, ... }:

let
  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
in
{
  imports = [
  	./apps/chromium.nix
  	./apps/firefox.nix
  	./apps/neovim.nix

  	./apps/renoise.nix

	./defaults.nix
  ];

  programs.home-manager.enable = true;

  home.username = "mimir";
  home.homeDirectory = "/home/mimir";

  home.stateVersion = "21.05";

  nixpkgs.config = {
	  allowUnfree = true;
  };

  home.packages = with pkgs; [
    tmux
    ripgrep
    mosh

    discord
    alacritty
    tdesktop

    plexamp
    unstable.joplin-desktop

    unstable.bitwig-studio4
    libreoffice

    resilio-sync

    plasma-pa

    yubikey-agent

    pinentry-qt

  ];





  programs.bash.enable = true;
  programs.git = {
    enable = true;
    userName = "Mimir";
    userEmail = "mimir@xmppwocky.net";
  };
}
