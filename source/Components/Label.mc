import Toybox.Lang;
using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;

module Components {
  enum LabelAnchor {
    CENTER = 0,
    LEFT,
  }

  class Label extends Base {
    typedef Params as {
      :color as Number,
      :text as String,
      :data as Symbol,
      :font as Object,
      :anchor as LabelAnchor or Null,
    };

    var color;
    var text;
    var font, loadedFont;
    var data;
    var anchor = CENTER;
    // var offsetRadius, offsetAngle, offsetParent;
    // var x, y;

    function initialize(params as Params) {
      // System.println("Label: initizlised " + identifier);
      Base.initialize(params);
      // self.x = Layout.center.x;
      // self.y = Layout.center.y;

      // Assign params
      self.color = params.get(:color);
      self.text = params.get(:text);
      self.font = params.get(:font);
      self.data = params.get(:data);
      if (params.hasKey(:anchor)) { self.anchor = params.get(:anchor); }

      // if (self.data != null) {
      //   System.println("Register for data for " + self.data);
      //   Data.listen(self.data as Symbol, self);
      // }

      self.buildFont();
      self.updateState();
    }

    function updateState() {
      if (self.data != null) {
        var text = Data.lookup(self.data);
        // System.println("Update " + identifier + " state from " + self.text + " to " + text);
        self.text = text;
      }
    }

    function draw(dc) {
      if (self.offsetRadius != null) {
        updateState();
        // self.positionWithOffset(dc);
      }
      // self.x = self.offset.x - (self.getWidth(dc) / 2);
      if (self.anchor == CENTER) {
        self.x = offset.x - (self.getWidth(dc) / 2);
      }
      self.y = offset.y;

      // var font = Fonts.get(Theme.Typography.primary, self.size);
      // System.println("Draw " + identifier + " with " + font.name);
      dc.setColor(self.color, Graphics.COLOR_TRANSPARENT);
      // dc.setColor(self.color, Graphics.COLOR_GREEN);
      dc.drawText(
        self.x,
        self.y,
        self.loadedFont,
        // font.resource,
        self.text,
        Graphics.TEXT_JUSTIFY_LEFT | Graphics.TEXT_JUSTIFY_VCENTER
      );
    }

    function getWidth(dc) {
      return dc.getTextWidthInPixels(self.text.toString(), self.loadedFont);
    }

    function getHeight(dc) {
      return dc.getFontHeight(self.loadedFont);
    }

    function setPosition(left as Number, top as Number) {
      // System.println("Set " + identifier + " width " + left);
      self.x = left;
      self.y = top;
    }

    function buildFont() {
      switch (self.font) {
        case :primary:
          self.loadedFont = Fonts.get(Theme.Typography.primary);
          break;
        case :secondary:
          self.loadedFont = Fonts.get(Theme.Typography.secondary);
          break;
        case :tertiary:
          self.loadedFont = Fonts.get(Theme.Typography.tertiary);
          break;
        case :smallest:
          self.loadedFont = Fonts.get(Theme.Typography.smallest);
          break;
        default:
          self.loadedFont = Fonts.get(self.font);
      }
    }

    // function positionWithOffset(dc) {
    //   var origin = Layout.center;
    //   if (self.offsetParent != null) {
    //     origin = offsetParent.getPosition();//findSiblingById(self.offsetParentId).getPosition();
    //   }

    //   var offset = offsetFromPoint(origin, rem(self.offsetRadius), self.offsetAngle);
    //   self.x = offset.x - (self.getWidth(dc) / 2);
    //   self.y = offset.y;
    // }

    function buildPosition() {
    }
  }
}
