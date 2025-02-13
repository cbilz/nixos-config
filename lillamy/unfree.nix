{ lib }:
let
  whitelist = [
    "steam"
    "steam-original"
    "steam-run"
    "steam-unwrapped"
  ];
in
rec {
  predicate = pkg: builtins.elem (lib.getName pkg) whitelist;
  importWithPredicate =
    path: attrs:
    import path (
      lib.attrsets.recursiveUpdate attrs {
        config.allowUnfreePredicate = predicate;
      }
    );
}
