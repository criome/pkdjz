{
  lib,
  stdenv,
  runCommandLocal,
  mkHugoWebsite,
  fromYAML,
  toTomlFile,
  hugoThemes,
}:

{ src, domain }:
let
  indexContentString = builtins.readFile (src + /_index.md);
  indexSplitStrings = lib.splitString "---\n" indexContentString;
  indexFrontMatter = builtins.elemAt indexSplitStrings 1;
  indexData = fromYAML indexFrontMatter;

  theme = indexData.theme or "hugo-PaperMod";
  themeDatom = hugoThemes.${theme};

  baseHugoConfig = {
    title = indexData.title;
    baseURL = "https://${domain}/";
    inherit theme;
  };

  themeSpecificConfig = themeDatom.mkConfig indexData;
  hugoConfig = baseHugoConfig // themeSpecificConfig;

  configFileName = "hugo.json";
  configJson = std.toJSON hugoConfig;
  configFile = std.toFile configFileName configJson;

  hugoSrcName = domain + "-hugo-BuildEnv";

  buildEnv = runCommandLocal hugoSrcName { } ''
    mkdir -p $out/themes
    cd $out
    ln -s ${src} ./content
    ln -s ${configFile} ./${configFileName}
    ln -s ${themeDatom.src} ./themes/${theme}
  '';

  build = mkHugoWebsite { src = buildEnv; };
in
{
  inherit build buildEnv;
}
