{ lib, pkgs }:
let
  mkPlugin = plugin: configFile: {
    inherit plugin;
    type = "lua";
    config = lib.fileContents configFile;
  };
in
with pkgs.vimPlugins;
[
  (mkPlugin comment-nvim ./comment.lua)
  (mkPlugin leap-nvim ./leap.lua)
  (mkPlugin lualine-nvim ./lualine.lua)
  (mkPlugin melange-nvim ./melange.lua)
  (mkPlugin nvim-lspconfig ./lspconfig.lua)
  (mkPlugin nvim-treesitter.withAllGrammars ./treesitter.lua)
  (mkPlugin telescope-nvim ./telescope.lua)
  (mkPlugin telescope-fzf-native-nvim ./telescope-fzf.lua)
  (mkPlugin undotree ./undotree.lua)
  (mkPlugin vim-fugitive ./fugitive.lua)
  (mkPlugin vimtex ./vimtex.lua)
  (mkPlugin zig-vim ./zig.lua)
]
