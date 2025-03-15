{
  description = "pkdjz - Some packages as Nix Atom";

  inputs = {
    atom.url = "github:LiGoldragon/atom/atomicFlake-v1";
    system.url = "github:criome/system";

    nixpkgs-lib.url = "github:nix-community/nixpkgs.lib";
    nixpkgs-lib.flake = false;

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    omnix.url = "github:juspay/omnix";
    omnix.inputs.nixpkgs.follows = "nixpkgs";

    zed.url = "github:zed-industries/zed";
    zed.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs: inputs.atom.mkAtomicFlake inputs (./. + "/pkdjz@.toml");
}
