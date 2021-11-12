{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";

    mimir-home.url = "path:/home/mimir/dotfiles/mimir-home";
  };

  outputs = { self, home-manager, nixpkgs, mimir-home }: {
    nixosConfigurations.mimir-nixos-fw = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./machines/mimir-nixos-fw/configuration.nix

        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.mimir = mimir-home.outputs.lib;
        }
      ];
    };
  };
}
