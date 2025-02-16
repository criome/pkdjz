socialsData:
let
  implementationsIndex = {
    telegram.url = "https://t.me/${socialsData.telegram}";
  };

in
std.intersectAttrs socialsData implementationsIndex
