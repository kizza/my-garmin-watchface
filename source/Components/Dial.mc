import Toybox.Lang;
using Toybox.Graphics as Gfx;

module Components {
  class Dial extends Base {
    typedef Params as {
      :arcStart as Number,
      :arcEnd as Number,
      :arcRadius as Number,
      :arcThickness as Number,
      :variant as Number or Null,
      :iconChar as String or Null,
      :data as Symbol,
      :foreground as Array<Number>,
      :background as Number,
    };

    var data;
    var foreground as Array<Number> = [];
    var background as Number;

    var arc;
    var label;
    var icon;

    function initialize(params) {
      Base.initialize(params);
      self.data = params.get(:data);
      self.foreground = params.get(:foreground);
      self.background = params.get(:background);

      var variant = Components.RoundedArc.SOLID;
      if (params.hasKey(:variant)) {variant = params.get(:variant);}

      arc = new Components.RoundedArc({
        :identifier => self.identifier + "arc",
        :start => params.get(:arcStart),
        :end => params.get(:arcEnd),
        :variant => variant,
        :radius => params.get(:arcRadius),
        :thickness => params.get(:arcThickness),
        :background => params.get(:background),
        :offsetRadius => params.get(:offsetRadius),
        :offsetAngle => params.get(:offsetAngle),
      });

      if (params.hasKey(:label)) {
        label = new Components.Label({
          :text => params.get(:label),
          :font => params.get(:font),
          :color => self.foreground[0],
          :offsetParent => arc,
          :offsetRadius => params.get(:arcRadius) - (params.get(:arcThickness) / 2),
          :offsetAngle => calculateArcOpenCenterAngle(arc),
        });
      }

      if (params.hasKey(:iconChar)) {
        icon = new Components.Icon({
          :text => params.get(:iconChar),
          :color => self.foreground[0],
          :offsetParent => arc,
          :offsetRadius => params.get(:arcRadius) - (params.get(:arcThickness) / 2),
          :offsetAngle => calculateArcOpenCenterAngle(arc),
        });
      }
    }

    // Find the cetner of the gap (opening) and return that point
    function calculateArcOpenCenterAngle(arc) {
      var gapAngleLength = traversedAngleLength(arc.end, arc.start);
      return incrementAngle(arc.end, gapAngleLength / 2);
    }

    function draw(dc) {
      assignArcAttributes();
      arc.draw(dc);

      if (label) { label.draw(dc); }
      if (icon) { icon.draw(dc); }
    }

    function assignArcAttributes() {
      var percent = Data.lookup(self.data);
      var boundPercent = mod(percent, 1.0);
      if (boundPercent == 0.0 && percent > 0) {
        boundPercent = 1.0; // Mod excludes this value
      }

      var laps = max(0, toInteger(Math.floor(percent - 0.01)));
      arc.percentage = boundPercent;
      var colourIndex = min(laps, self.foreground.size() - 1);
      arc.foreground = self.foreground[colourIndex]; // Don't overindex colors
      arc.background = self.background;
      if (laps > 0 && background != Gfx.COLOR_TRANSPARENT) { // Lapped background
        arc.background = self.foreground[colourIndex - 1];
      }
    }
  }
}
