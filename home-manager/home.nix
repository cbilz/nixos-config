{
  config,
  lib,
  pkgs,
  ...
}:

let
  unstable = import <nixos-unstable> {
    config.allowUnfreePredicate =
      pkg:
      builtins.elem (lib.getName pkg) [
      ];
  };
in
{
  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "obsidian"
    ];

  home = {
    username = "ck";
    homeDirectory = "/home/ck";
    keyboard = {
      layout = "de";
      variant = "nodeadkeys";
    };
    sessionPath = [ "$HOME/dev/nix-scripts" ];
    packages = import ./packages.nix { inherit lib pkgs; };
  };

  programs = import ./programs { inherit lib pkgs; };

  # TODO: Configure starship using the programs.starship module
  xdg.configFile."starship.toml".source = ~/dotfiles/starship/starship.toml;

  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-chinese-addons
      fcitx5-gtk
      libsForQt5.fcitx5-qt
    ];
  };

  fonts.fontconfig.enable = true;

  gtk = {
    enable = true;
    theme = {
      name = "Adwaita";
      package = pkgs.gnome-themes-extra;
    };
  };

  services.gpg-agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-all;
  };

  # This GC run could become redundant if the following issue is resolved:
  # https://github.com/NixOS/nix/issues/8508
  nix.gc = {
    automatic = true;
    persistent = true;
    frequency = "weekly";
    randomizedDelaySec = "10min";
    options = "--delete-older-than 30d";
  };

  home.stateVersion = "22.11"; # DON'T CHANGE! Read the documentation.
}
