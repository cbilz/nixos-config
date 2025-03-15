require("telescope").setup({
  extensions = {
    undo = {
      mappings = {
        i = {
          ["<cr>"] = require("telescope-undo.actions").restore,
          ["<S-cr>"] = false,
          ["<C-cr>"] = false,
          ["<C-y>"] = false,
          ["<C-r>"] = false,
        },
        n = {
          ["y"] = false,
          ["Y"] = false,
          ["u"] = false,
        },
      },
    },
  },
})
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>tf', builtin.find_files, {})
vim.keymap.set('n', '<leader>tg', builtin.git_files, {})
vim.keymap.set('n', '<leader>ts', builtin.live_grep, {})
vim.keymap.set('n', '<leader>tm', builtin.grep_string, {})
vim.keymap.set('n', '<leader>tb', builtin.buffers, {})
