{
  boot.kernelPatches = [{
    name = "hardened-usercopy"
    patch = null;
    extraConfig = ''
      CONFIG_HARDENED_USERCOPY=y
    '';
  }];
}
}
