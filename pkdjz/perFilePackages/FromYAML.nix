{ remarshal, runCommandLocal }:

YAMLString:
let
  formatFlags = "--from yaml --to json";
  convertCmd = "${remarshal}/bin/remarshal ${formatFlags} --input -";

  jsonFile = runCommandLocal "FromYamlArtefact" { inherit YAMLString; } ''
    printf '%s' """$YAMLString""" | ${convertCmd} --output $out
  '';

  jsonString = std.readFile jsonFile;

in
std.fromJSON jsonString
