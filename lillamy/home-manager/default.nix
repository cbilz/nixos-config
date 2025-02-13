{
  config,
  lib,
  pkgs,
  ...
}:

{
  home = {
    username = "boni";
    homeDirectory = "/home/boni";
    keyboard.layout = "de";
    packages = import ./packages.nix { inherit lib pkgs; };
  };

  programs = import ./programs { inherit lib pkgs; };

  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-chinese-addons
    ];
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

  home.stateVersion = "24.11"; # DON'T CHANGE! Read the documentation.
}
