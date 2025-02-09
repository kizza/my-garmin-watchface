{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  shellHook = ''
    export GARMIN_HOME="$HOME/Library/Application Support/Garmin/ConnectIQ"
    export GARMIN_SDK_HOME="`cat "$GARMIN_HOME/current-sdk.cfg"`/bin"
    export PATH="$PATH:$GARMIN_SDK_HOME"
  '';
}
