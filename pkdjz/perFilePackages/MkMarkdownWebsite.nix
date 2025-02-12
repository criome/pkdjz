{
  lib,
  stdenv,
  runCommandLocal,
  mkHugoWebsite,
  fromYAML,
  toTomlFile,
}:

{ src, domain }:
let
  indexContentString = builtins.readFile (src + /_index.md);
  indexSplitStrings = lib.splitString "---\n" indexContentString;
  indexFrontMatter = builtins.elemAt indexSplitStrings 1;
  indexData = fromYAML indexFrontMatter;

  hugoConfig = {
    title = indexData.title;
    baseURL = "https://${domain}/";
  };

  configFile = toTomlFile "hugo.toml" hugoConfig;

  hugoSrcName = domain + "-hugoSrc";

  hugoSrc = runCommandLocal hugoSrcName { } ''
    mkdir -p $out/
    cd $out
    ln -s ${src} ./content
    ln -s ${configFile} ./hugo.toml
  '';

in
mkHugoWebsite { src = hugoSrc; }
