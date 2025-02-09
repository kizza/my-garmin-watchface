import Toybox.Lang;
using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;

module Components {
  class Icon extends Components.Label {
    enum Icon {
      STEPS = 0,
      HEART,
    }

    typedef Params as {
      :color as Number,
      :text as String,
      :font as Object,
    };

    function initialize(params as Params) {
      params[:text] = "0";
      params[:font] = Rez.Fonts.IconFont;
      Label.initialize(params);
    }
  }
}
