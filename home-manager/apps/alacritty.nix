{ pkgs, ... }:

{
  programs.alacritty.enable = true;
  programs.alacritty.settings = {
    key_bindings = [
      {
        key = "N";
        mods = "Control|Shift";
        action = "SpawnNewInstance";
      }
    ];
    shell = {
      program = "${pkgs.tmux}/bin/tmux";
      args = [ "new-session" "-A" "-D" "-s" "main" ];
    };
  };
}
