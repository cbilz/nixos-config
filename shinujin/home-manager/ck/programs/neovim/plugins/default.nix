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
  telescope-fzf-native-nvim
  telescope-ui-select-nvim
  telescope-undo-nvim
  (mkPlugin vim-fugitive ./fugitive.lua)
  vim-repeat
  vim-rhubarb
  (mkPlugin vimtex ./vimtex.lua)
  (mkPlugin zig-vim ./zig.lua)
]
