{ yj, runCommandLocal }:

name: value:
let
  formatFlag = "-jt";
  prettyFlag = "-i";
  convertCmd = "${yj}/bin/yj ${formatFlag} ${prettyFlag}";

  valueJSON = std.toJSON value;

  tomlFile = runCommandLocal name { inherit valueJSON; } ''
    printf '%s' """$valueJSON""" | ${convertCmd} > $out
  '';

in
tomlFile
