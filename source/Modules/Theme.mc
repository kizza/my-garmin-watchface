using Toybox.WatchUi as Ui;

module Theme {
  function initialize() {
  }

  module Colors {
    function get(key) {
      return {
        :placeholder => 0x2B2B2B
      }[key];
    }
  }

  module Typography {
    var primary;
    var secondary;
    var tertiary;
    var smallest;

    // var largeFont;
    // var normalFont;
    // var smallFont;
    // var smallestFont;

    function initialize() {
      // primary = Rez.Fonts.FugazOneRegular144;
      // primary = Rez.Fonts.FugazOneRegular120;

      primary = Rez.Fonts.AdventProRegular120;
      secondary = Rez.Fonts.AdventProThin120;
      tertiary = Rez.Fonts.AdventProRegular24;
      // smallest = Rez.Fonts.AdventProRegular16;
      smallest = Rez.Fonts.BalooBhaina2Regular16;

      // primary = Rez.Fonts.PoiretOneRegular120;
      // secondary = Rez.Fonts.AdventProRegular90;
      // tertiary = Rez.Fonts.PoiretOneRegular20;
      // smallest = Rez.Fonts.BalooBhaina2Regular16;
    }
  }
}
