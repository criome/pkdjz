let
  flakePackageSrcs = { inherit (use) zed omnix; };
  mkFlakePackage = name: src: src.packages.${system}.default;
  flakePackages = std.mapAttrs mkFlakePackage flakePackageSrcs;

  hugoThemes = { inherit (use) hugo-themes; };

  nonFilePackages = flakePackages // hugoThemes;

  filePackages = mod.mkPkgsWithNamedSrc mod.perFilePackages nonFilePackages;

  Packages = filePackages // nonFilePackages;

in
{
  inherit Packages;
}
