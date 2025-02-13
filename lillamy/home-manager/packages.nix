{ lib, pkgs }:
let
  unfree = import ../unfree.nix { inherit lib; };
  unstable = unfree.importWithPredicate <nixos-unstable> { };
in
with pkgs;
[
  coolreader
  paperwork
  restic
  texlive.combined.scheme-full
  texworks
]
