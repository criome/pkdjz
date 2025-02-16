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
  frontmatterString = builtins.elemAt indexSplitStrings 1;
  frontmatterData = fromYAML frontmatterString;

  indexData = {
    main = std.elemAt indexSplitStrings 2;
  } // frontmatterData;

  theme = indexData.theme or "hugo-theme-hello-friend-ng";
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
