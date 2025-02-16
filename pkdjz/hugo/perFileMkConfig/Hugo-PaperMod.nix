indexData:
let
  inherit (use.nixpkgs-atom) lib;

  socialIndex = {
    telegram.url = "https://t.me/${indexData.telegram}";
  };

  indexDataSocials = std.intersectAttrs socialIndex indexData;

  mkSocialIcon =
    name: value:
    let
      indexData = socialIndex.${name};
      inherit (indexData) url;
      baseResult = { inherit name url; };
      hasTitle = std.hasAttr "title" indexData;
      optionalTilte = std.optionalAttrs hasTitle indexData.title;
    in
    baseResult;

  socialIcons = lib.mapAttrsToList mkSocialIcon indexDataSocials;

in
{
  params = {
    inherit socialIcons;
    description = "Description";
    author = "author";
    profileMode = {
      enable = true;
      title = "title";
    };
  };
}
