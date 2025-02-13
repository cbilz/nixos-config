{ lib }:
let
  whitelist = [
    "steam"
    "steam-original"
    "steam-run"
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
