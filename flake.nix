{
  description = "pkdjz - Some packages as Nix Atom";
  inputs.atom.url = "github:LiGoldragon/atom";
  outputs = { atom, ... }: atom.mkAtomicFlake { manifest = ./. + "/pkdjz@.toml"; };
}
