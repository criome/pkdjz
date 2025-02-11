{ convfmt }:

YAMLString:
let
  formatFlag = "-yj";
  prettyFlag = "-i";
  convertCmd = "${yj}/bin/yj ${formatFlag} ${prettyFlag}";

  jsonFile = runCommandLocal "FromYamlArtefact" { inherit YAMLString; } ''
    printf '%s' """$YAMLString""" | ${convertCmd} > $out
  '';

  jsonString = std.readFile jsonFile;

in
std.fromJSON jsonString
