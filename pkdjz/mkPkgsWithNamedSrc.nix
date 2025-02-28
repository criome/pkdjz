packageFns: additionalScope:
let
  inherit (get.nixpkgs-atom) pkgs;

  callPackageWithSrc =
    name: function:
    let
      requestedArguments = std.functionArgs function;
      requiresSrc = std.hasAttr "src" requestedArguments;
      srcNameIsInUse = std.hasAttr name get;
      usedSrc.src = get.${name};
      optionalSrc = if (requiresSrc && srcNameIsInUse) then usedSrc else { };
      scope = pkgs // additionalScope // packages // optionalSrc;
      arguments = std.intersectAttrs requestedArguments scope;
    in
    function arguments;

  packages = std.mapAttrs callPackageWithSrc packageFns;

in
packages
