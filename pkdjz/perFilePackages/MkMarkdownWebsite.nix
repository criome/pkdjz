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

  theme = indexData.theme or "hugo-PaperMod";
  themeSrc = hugo-themes.${theme};

  hugoConfig = {
    title = indexData.title;
    baseURL = "https://${domain}/";
    inherit theme;
  };

  configFileName = "hugo.json";
  configFile = std.toFile configFileName (std.toJSON hugoConfig);

  hugoSrcName = domain + "-hugoSrc";

  buildEnv = runCommandLocal hugoSrcName { } ''
    mkdir -p $out/themes
    cd $out
    ln -s ${src} ./content
    ln -s ${configFile} ./${configFileName}
    ln -s ${themeSrc} ./themes/${theme}
  '';

  build = mkHugoWebsite { src = buildEnv; };
in
{
  inherit build buildEnv;
}
