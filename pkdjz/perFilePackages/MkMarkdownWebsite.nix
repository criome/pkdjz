{
  lib,
  stdenv,
  runCommandLocal,
  mkHugoWebsite,
  fromYAML,
  toTomlFile,
  hugo-themes,
}:

{ src, domain }:
let
  indexContentString = builtins.readFile (src + /_index.md);
  indexSplitStrings = lib.splitString "---\n" indexContentString;
  indexFrontMatter = builtins.elemAt indexSplitStrings 1;
  indexData = fromYAML indexFrontMatter;

  themeName = indexData.theme or "hugo-coder";
  themeSrc = hugo-themes.${themeName};

  hugoConfig = {
    title = indexData.title;
    baseURL = "https://${domain}/";
    theme = themeName;
  };

  configFile = toTomlFile "hugo.toml" hugoConfig;

  hugoSrcName = domain + "-hugoSrc";

  buildEnv = runCommandLocal hugoSrcName { } ''
    mkdir -p $out/themes
    cd $out
    ln -s ${src} ./content
    ln -s ${configFile} ./hugo.toml
    ln -s ${themeSrc} ./themes/${themeName}
  '';

  build = mkHugoWebsite { src = buildEnv; };
in
{
  inherit build buildEnv;
}
