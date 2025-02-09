import Toybox.Lang;
using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;

module Components {
  class Base extends Ui.Drawable {
    typedef Params as {
      :offsetRadius as Float or Number or Null,
      :offsetAngle as Number or Null,
      :offsetParentId as String or Null, // for findDrawableById
      :offsetParent as Base or Null, // or set directly
    };

    var origin as Types.Point or Null; // Where offsets are calculated from
    var offset as Types.Point or Null; // Where the offset is set to
    var offsetRadius = 0;
    var offsetAngle = 0;
    var offsetParentId, offsetParent;
    var x, y;

    function initialize(params as Params) {
      // System.println("Label: initizlised " + identifier);
      Drawable.initialize(params);
      self.x = Layout.center.x;
      self.y = Layout.center.y;

      // Assign params
      if (params.hasKey(:offsetRadius)) { self.offsetRadius = params.get(:offsetRadius); }
      if (params.hasKey(:offsetAngle)) { self.offsetAngle = params.get(:offsetAngle); }
      if (params.hasKey(:offsetParentId)) { self.offsetParentId = params.get(:offsetParentId); }
      if (params.hasKey(:offsetParent)) { self.offsetParent = params.get(:offsetParent); }

      // Lookup siblings
      if (self.offsetParentId != null) {
        System.println("Label looking up parent by id " + self.offsetParentId);
        self.offsetParent = findSiblingById(self.offsetParentId);
      }

      initializePosition();
    }

    // Primary position, from an origin using offsetRadius and offsetAngle
    function initializePosition() {
      origin = Layout.center;
      if (self.offsetParent != null) {
        origin = offsetParent.getPosition();
      }

      if (self.offsetRadius != null && self.offsetAngle != null) {
        offset = offsetFromPoint(origin, rem(self.offsetRadius), self.offsetAngle);
      } else {
        offset = origin;
      }

      self.x = offset.x;// - (self.getWidth(dc) / 2);
      self.y = offset.y;
    }

    // var _initializedPositionWithWidth = false;
    // function initializePositionWithWidth(dc) {
    //   // no op
    //   self.x = offset.x;// - (self.getWidth(dc) / 2);
    // }

//     function updateState() {
//       if (self.data != null) {
//         var text = Data.lookup(self.data);
//         // System.println("Update " + identifier + " state from " + self.text + " to " + text);
//         self.text = text;
//       }
//     }

    function getPosition() {
      return new Types.Point(self.x, self.y);
    }

    function setOffset(left as Number, top as Number) {
      self.offset = new Types.Point(left, top);
    }

    function setPosition(left as Number, top as Number) {
      self.x = left;
      self.y = top;
    }

    function findSiblingById(id as String) as Base {
      return Application.getApp().view.findDrawableById(id);
    }
  }
}
