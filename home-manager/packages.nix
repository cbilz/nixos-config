{ lib, pkgs }:
let
  unfree = import ../unfree.nix { inherit lib; };
  unstable = unfree.importWithPredicate <nixos-unstable> { };
in
with pkgs;
[
  authenticator
  bc
  cached-nix-shell
  chatterino2
  compsize
  cook-cli
  dconf-editor
  dconf2nix
  exiftool
  ffmpeg-full
  file
  gimp
  gnome-sound-recorder
  gnome-tweaks
  # TODO: Provide hunspell and dictionaries only for libreoffice.
  hunspell
  hunspellDicts.de_DE
  hunspellDicts.de_DE
  hunspellDicts.en_GB-ise
  hunspellDicts.en_US
  imagemagick
  kdePackages.kruler
  liberation_ttf
  libreoffice
  losslesscut-bin
  man-pages
  man-pages-posix
  nixfmt-rfc-style
  obsidian
  paperwork
  pavucontrol
  poppler_utils
  qrencode
  # TODO: Configure qutebrowser bindings, search engines, etc. through programs.qutebrowser
  qutebrowser
  restic
  shotwell
  # TODO: Configure email accounts using accounts.email
  # TODO: Configure thunderbird via programs.thunderbird
  thunderbird
  tree
  unzip
  urlwatch
  wget
  wl-clipboard
  # TODO: Is xclip still needed?
  xclip
]
