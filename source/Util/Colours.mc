using Toybox.Graphics as Gfx;

class Colours {
  static const RED = 0xFF0000;
  static const ORANGE = 0xFF5500;
  static const YELLOW = 0xFFFF00;
  static const GREEN = 0x00FF00;
  static const BLUE = 0x00AAFF;
  static const PURPLE = 0xAA00FF;
  static const PINK = 0xFF34B8;
  static const AQUA = 0x00FFFF;
  static const MINT = 0x56FFAC;
  static const WHITE = 0xFFFFFF;
  static const BLACK = 0x000000;
  static const DARK = 0x222222;
}

function getSecondaryColour(primaryColour) {
  if (primaryColour == Colours.RED) { return Colours.ORANGE; }
  if (primaryColour == Colours.ORANGE) { return Colours.RED; }
  if (primaryColour == Colours.YELLOW) { return Colours.AQUA; }
  if (primaryColour == Colours.GREEN) { return Colours.WHITE; }
  if (primaryColour == Colours.BLUE) { return Colours.YELLOW; }
  if (primaryColour == Colours.PURPLE) { return Colours.MINT; }
  if (primaryColour == Colours.PINK) { return Colours.YELLOW; }
  if (primaryColour == Colours.AQUA) { return Colours.WHITE; }
  if (primaryColour == Colours.MINT) { return Colours.PURPLE; }
  return primaryColour;
}
