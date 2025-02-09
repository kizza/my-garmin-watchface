import Toybox.Lang;
using Toybox.Application as App;
using Toybox.Graphics as Gfx;


module Settings {
  typedef Settings as Dictionary<Symbol, String or Number or Boolean>;

  var _settings;

  function read() {
    var themeColour = getColour("Theme", Colours.MINT);
    var secondaryColour = getSecondaryColour(themeColour);

    _settings = {
      :themeColour => themeColour,
      :enlargeHours => getProperty("EnlargeHours"),
      :hourFont => getProperty("HourFont"),
      :hourColour => getColour("HourColour", 0xFFFFFF),
      :minuteColour => getColour("MinuteColour", themeColour),
      :dateColour => getColour("DateColour", Gfx.COLOR_WHITE),
      :metricColour => getColour("MetricColour", themeColour),
      :dialColour => getColour("DialColour", themeColour),
      :bonusDialColour => getColour("BonusDialColour", Colours.PINK),
      :moveBarColour => getColour("MoveBarColour", secondaryColour),
      :moveBarColourAlmostFull => getColour("MoveBarColourAlmostFull", Colours.ORANGE),
      :moveBarColourFull => getColour("MoveBarColourFull", Colours.RED)
    };

    // settings[:hourFont] = 1;
    // settings[:dialColour] = 0xFFFFFF;
    // settings[:hourColour] = 0xFF0000;
    // settings[:dateColour] = Colours.PINK;
    // settings[:metricColour] = Colours.ORANGE;
    // settings[:moveBarColour] = 0x56FFAC;

  }

  function get(key as Symbol) as String or Number or Boolean {
    return (_settings as Settings)[key];
  }
}

function getSettings() {
}

function getProperty(key) as String or Number or Boolean {
  // return App.getApp().getProperty(key);
  return App.Properties.getValue(key);
}

function getColour(key, fallback) as Number {
  // var value = App.getApp().getProperty(key).toNumber();
  var value = App.Properties.getValue(key).toNumber();
  if (value != -1) {
    return value;
  }
  return fallback;
}
