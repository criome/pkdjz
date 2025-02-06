packageFns:
let
  inherit (use.nixpkgs-atom) pkgs;

  callPackageWithSrc =
    name: function:
    let
      requestedArguments = std.functionArgs function;
      requiresSrc = std.hasAttr "src" requestedArguments;
      srcNameIsInUse = std.hasAttr name use;
      usedSrc.src = use.${name};
      optionalSrc = if (requiresSrc && srcNameIsInUse) then usedSrc else { };
      scope = pkgs // packages // optionalSrc;
      arguments = std.intersectAttrs requestedArguments scope;
    in
    function arguments;

  packages = std.mapAttrs callPackageWithSrc packageFns;

in
packages
