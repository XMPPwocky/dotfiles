{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";

    mimir-home.url = "path:/home/mimir/dotfiles/mimir-home";
  };

  outputs = { self, home-manager, nixpkgs, mimir-home }:
    let
      modules = {
        hardening = modules/hardening.nix;

        #modules/enable-flakes.nix

        #modules/power-utils.nix
        #modules/basic-users.nix
        #modules/desktop.nix
        #modules/audio.nix
        #modules/ps5-controller-udev.nix
        #modules/tailscale.nix
      };
    in
    {
      nixosModules = modules;

      nixosConfigurations.mimir-nixos-fw = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./machines/mimir-nixos-fw/configuration.nix

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.mimir = mimir-home.outputs.hmCfg;
          }

	  modules.hardening
        ];
      };
    };
}
