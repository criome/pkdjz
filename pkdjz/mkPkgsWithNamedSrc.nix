packageFns:
let
  pkgs = use.nixpkgs { inherit system; };

  mkFunction =
    { scope, function }:
    let
      requestedArguments = std.functionArgs function;
      arguments = std.intersectAttrs requestedArguments scope;
    in
    function arguments;

  callPackageWithSrc =
    name: function:
    let
      nameIsInDeps = std.hasAttr name use;
      usedSrc.src = use.${name};
      optionalSrc = if nameIsInDeps then usedSrc else { };
      scope = optionalSrc;
    in
    mkFunction { inherit scope function; };

  packages = std.mapAttrs callPackageWithSrc packageFns;

in
packages
