{
  stdenv,
  fromYAML,
  hugo,
}:

{ src }:
let
  indexContentString = builtins.readFile (src + /_index.md);
  indexSplitStrings = lib.splitString "+++\n" indexContentString;
  indexFrontMatter = builtins.elemAt indexSplitStrings 1;
  indexData = fromYAML indexFrontMatter;
  title = indexData.title;

in
stdenv.mkDerivation {
  name = title + "-hugoWebsite";
  version = src.shortRev or "unversioned";
  inherit src;

  nativeBuildInputs = [ hugo ];

  buildPhase = ''
    ln -s ${src} ./content
    hugo build
  '';

  installPhase = ''
    mkdir -p $out
    cp -r public/* $out
  '';
}
