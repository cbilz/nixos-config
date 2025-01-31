{ lib, pkgs }:
{
  enable = true;
  defaultEditor = true;
  extraLuaConfig = lib.fileContents ./init.lua;
  extraPackages = with pkgs; [
    clang-tools
    lua-language-server
    nixd
    ripgrep
  ];
  plugins = import ./plugins { inherit lib pkgs; };
}
