{
  lib,
  stdenv,
  fromYAML,
  hugo,
}:

{ src }:
stdenv.mkDerivation {
  name = title + "-hugoWebsite";
  version = src.shortRev or "unversioned";
  inherit src;

  nativeBuildInputs = [ hugo ];

  buildPhase = ''
    hugo build
  '';

  installPhase = ''
    mkdir -p $out
    cp -r public/* $out
  '';
}
