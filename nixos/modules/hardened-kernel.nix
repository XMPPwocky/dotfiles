{
  boot.kernelPatches = [{
    name = "hardened-usercopy";
    patch = null;
    extraConfig = ''
      CONFIG_HARDENED_USERCOPY=y
    '';
  }
    {
      name = "fortify-source";
      patch = null;
      extraConfig = ''
        CONFIG_FORTIFY_SOURCE=y
      '';
    }
    {
      name = "slab-freelist-randomization";
      patch = null;
      extraConfig = ''
        CONFIG_SLAB_FREELIST_RANDOM=y
      '';
    }
    {
      name = "gcc-hardening-plugins";
      patch = null;
      extraConfig = ''
        # Enable GCC Plugins
        CONFIG_GCC_PLUGINS=y

        # Gather additional entropy at boot time for systems that may not have appropriate entropy sources.
        CONFIG_GCC_PLUGIN_LATENT_ENTROPY=y

        # Force all structures to be initialized before they are passed to other functions.
        # When building with GCC:
        CONFIG_GCC_PLUGIN_STRUCTLEAK=y
        CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL=y

        # Wipe stack contents on syscall exit (reduces stale data lifetime in stack)
        CONFIG_GCC_PLUGIN_STACKLEAK=y

        # Randomize the layout of system structures. This may have dramatic performance impact, so
        # use with caution or also use CONFIG_GCC_PLUGIN_RANDSTRUCT_PERFORMANCE=y
        CONFIG_GCC_PLUGIN_RANDSTRUCT=y
      '';
    }];
}
