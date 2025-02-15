name: src:
let
  isImplemented = std.hasAttr name mod.perFile-hugo-mkConfig;
  mkConfig = mod.perFile-hugo-mkConfig.${name};
  result = { inherit src mkConfig; };
  errorMsg = abort "Hugo theme ${name} lacks a `mkConfig` implementation";

in
if isImplemented then result else errorMsg
