{ pkgs, ... }:
{
  programs.tmux.enable = true;
  programs.tmux.extraConfig =
  ''
  set -g default-terminal "tmux-256color"
  set -ag terminal-overrides ",xterm-256color:RGB"
  '';
}
