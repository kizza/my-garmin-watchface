import Toybox.Lang;
using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;

module Components {
  class Labels extends Components.Container {
    typedef Params as {
      :datas as Array<Symbol>,
      :fonts as Array<Object>,
      :colors as Array<Number>,
      // :offsetRadius as Float or Number or Null,
      // :offsetAngle as Number or Null,
      // :offsetParent as String or Null,
    };

    var childCount = 0;

    function initialize(params as Params) {
      var fonts = params.get(:fonts);
      var datas = params.get(:datas);
      var colors = params.get(:colors);

      // if (params[:fonts] instanceof Lang.Array) {
      //   System.println("It's an array silly.");
      // } else {
      //   System.println("It is not an array! Argh!");
      // }

      // Determine quantity of children by max item count from arrays
      // (eg. could have multiple fonts, but one color)
      var paramCounts = [fonts, datas, colors] as Array<Array<Object>>;
      for (var i = 0; i < 1; i++) {
        if (paramCounts[i].size() > childCount) {
          childCount = paramCounts[i].size();
        }
      }
      System.println("Child count is " + childCount);

      var children = [];
      for (var i = 0; i < childCount; i++) {
        var label = new Components.Label({
          :font => fonts[i],
          :data => datas[i],
          :color => colors[i],
        });
        children.add(label);
      }

      Container.initialize({
        :children => children,
        :childNodes => children,
      });
    }

    function draw(dc) {
      self.onUpdate(dc);
      for (var i = 0; i < self.size; i++) {
        self.childNodes[i].draw(dc);
      }
    }
  }
}
