{
  users.mutableUsers = false;
  users.users.mimir = {
    isNormalUser = true;
    description = "Mimir";

    extraGroups = [ "audio" "jackaudio" "wheel" "networkmanager" ];

    hashedPassword = (builtins.readFile /etc/nixos/mimir_pwhash);
  };
}
