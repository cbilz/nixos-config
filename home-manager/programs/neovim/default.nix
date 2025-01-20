{ lib, pkgs }:
{
  enable = true;
  defaultEditor = true;
  extraLuaConfig = lib.fileContents ./init.lua;
  extraPackages = with pkgs; [
    ripgrep
  ];
  plugins = import ./plugins { inherit lib pkgs; };
}
