{
  description = "pkdjz - Some packages as Nix Atom";

  inputs = {
    atom.url = "github:LiGoldragon/atom";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-atom.url = "github:criome/nixpkgs-atom";
    nixpkgs-atom.inputs.nixpkgs.follows = "nixpkgs";

    omnix.url = "github:juspay/omnix";
    zed.url = "github:zed-industries/zed";
  };

  outputs = inputs: inputs.atom.mkAtomicFlake inputs (./. + "/pkdjz@.toml");
}
