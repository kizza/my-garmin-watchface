
class Store {
  var hours = 0;
  var mins = 0;

  function initialize() {
    setTime();
  }

  function mock() {

  }

  function setTime() {
    var systemTime = System.getClockTime();
    hours = systemTime.hour;
    mins = systemTime.min;
  }
}
