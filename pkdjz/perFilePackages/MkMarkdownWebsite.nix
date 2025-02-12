{
  lib,
  stdenv,
  runCommandLocal,
  mkHugoWebsite,
}:

{ src, domain }:
let
  indexContentString = builtins.readFile (src + /_index.md);
  indexSplitStrings = lib.splitString "---\n" indexContentString;
  indexFrontMatter = builtins.elemAt indexSplitStrings 1;
  indexData = fromYAML indexFrontMatter;

  baseConfig = {
    title = indexData.title;
    baseURL = "https://${domain}/";
  };

  hugoSrc = runCommandLocal { } ''
    mkdir -p $out/
    cd $out
    ln -s ${src} ./content
  '';

in
mkHugoWebsite { src = hugoSrc; }
