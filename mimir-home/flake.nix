{
  description = "A very basic flake";

  inputs = {
  };

  outputs = { self, nixpkgs }: {
    hmCfg = import ./home.nix;
  };
}
