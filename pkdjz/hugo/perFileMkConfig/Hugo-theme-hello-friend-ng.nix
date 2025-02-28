indexData:
let
  inherit (get.nixpkgs-atom) lib;

  mkSocial = name: value: {
    inherit name;
    inherit (value) url;
  };

  indexedSocialsData = pre.mkSocials (indexData.social or { });

in
{
  params = {
    homeSubtitle = indexData.main;
    description = indexData.description or null;
    author = indexData.author or null;
    social = lib.mapAttrsToList mkSocial indexedSocialsData;
  };
}
