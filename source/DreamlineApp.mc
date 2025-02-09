using Toybox.Application;
using Toybox.WatchUi as Ui;

class Dreamline extends Application.AppBase {
  var view = null;

  function initialize() {
    AppBase.initialize();
  }

  function getInitialView() {
    view = new MainView();

    if( Toybox.WatchUi has :WatchFaceDelegate ) {
      return [view, new WatchDelegate()];
    } else {
      return [view];
    }
  }

  function onSettingsChanged() {
    System.println("Settings changed");
    view.handleSettingsChange();
    Ui.requestUpdate();
  }
}
