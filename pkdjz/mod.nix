let
  filePackages = mod.mkPkgsWithNamedSrc mod.perFilePackages;

  flakePackageSrcs = { inherit (use) zed omnix; };

  mkFlakePackage = name: src: src.packages.${system}.default;

  flakePackages = std.mapAttrs mkFlakePackage flakePackageSrcs;

in
{
  Packages = filePackages // flakePackages;
}
