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
  (mkPlugin catppuccin-nvim ./catppuccin.lua)
  (mkPlugin comment-nvim ./comment.lua)
  (mkPlugin gitsigns-nvim ./gitsigns.lua)
  (mkPlugin leap-nvim ./leap.lua)
  (mkPlugin lualine-nvim ./lualine.lua)
  (mkPlugin nvim-lspconfig ./lspconfig.lua)
  (mkPlugin nvim-treesitter.withAllGrammars ./treesitter.lua)
  (mkPlugin telescope-nvim ./telescope.lua)
  (mkPlugin telescope-fzf-native-nvim ./telescope-fzf.lua)
  (mkPlugin telescope-undo-nvim ./telescope-undo.lua)
  (mkPlugin vim-fugitive ./fugitive.lua)
  (mkPlugin vim-repeat ./repeat.lua)
  (mkPlugin vim-rhubarb ./rhubarb.lua)
  (mkPlugin vimtex ./vimtex.lua)
  (mkPlugin zig-vim ./zig.lua)
]
