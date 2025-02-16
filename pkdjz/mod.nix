let
  flakePackageSrcs = { inherit (use) zed omnix; };
  mkFlakePackage = name: src: src.packages.${system}.default;
  flakePackages = std.mapAttrs mkFlakePackage flakePackageSrcs;

  inherit (mod.hugo) hugoThemes;

  nonFilePackages = flakePackages // {
    inherit hugoThemes;
  };

  filePackages = mod.mkPkgsWithNamedSrc mod.perFile-packages nonFilePackages;

  Packages = filePackages // nonFilePackages;

in
{
  inherit Packages;
}
