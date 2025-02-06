let
  filePackages = mod.mkPkgsWithNamedSrc mod.perFilePackages;

  mkFlakePackage = name: src: src.packages.${system}.default;

  flakePackages = std.mapAttrs mkFlakePackage { inherit (use) zed omnix; };

in
{
  Packages = filePackages // flakePackages;
}
