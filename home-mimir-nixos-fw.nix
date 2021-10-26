{ config, pkgs, ... }:

let
  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
in
{
  imports = [
  	./apps/chromium.nix
  	./apps/firefox.nix
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

    plexamp
    unstable.joplin-desktop

    unstable.bitwig-studio4

    resilio-sync

    plasma-pa
  ];

  programs.bash.enable = true;
  programs.git = {
    enable = true;
    userName = "Mimir";
    userEmail = "mimir@xmppwocky.net";
  };
}
