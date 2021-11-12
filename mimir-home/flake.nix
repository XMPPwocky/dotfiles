{
  description = "A very basic flake";

  inputs = {
    renoise.url = "path:/home/mimir/renoise";
    renoise.flake = false;
  };

  outputs = { self, nixpkgs, renoise }: {
    lib = import ./home.nix;
  };
}
