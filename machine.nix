# Per-machine facts. The work laptop is the one with secrets-majorrocket.nix;
# personal machines get mail, calendar/contacts and Syncthing.
rec {
  isWork = builtins.pathExists ./secrets-majorrocket.nix;
  isPersonal = !isWork;
}
