require("telescope").setup({
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown {}
    },
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

vim.keymap.set('n', '<leader>tt', builtin.resume, {})
vim.keymap.set('n', '<leader>tT', builtin.pickers, {})

vim.keymap.set('n', '<leader>tf', builtin.find_files, {})
vim.keymap.set('n', '<leader>tg', builtin.git_files, {})
vim.keymap.set('n', '<leader>ts', builtin.live_grep, {})
vim.keymap.set('n', '<leader>tm', builtin.grep_string, {})
vim.keymap.set('n', '<leader>tb', builtin.buffers, {})
vim.keymap.set('n', '<leader>tc', builtin.command_history, {})
vim.keymap.set('n', '<leader>tC', builtin.commands, {})
vim.keymap.set('n', '<leader>th', builtin.search_history, {})
vim.keymap.set('n', '<leader>th', builtin.marks, {})

vim.keymap.set('n', '<leader>tr', builtin.lsp_references, {})
vim.keymap.set('n', '<leader>tl', builtin.lsp_document_symbols, {})
vim.keymap.set('n', '<leader>td', builtin.diagnostics, {})
vim.keymap.set('n', 'gt', builtin.lsp_type_definitions, {})

vim.g.ck_lsp_auto_highlight = true

vim.api.nvim_create_autocmd('CursorHold', {
  callback = function(_)
    if vim.g.ck_lsp_auto_highlight then
      vim.lsp.buf.document_highlight()
    end
  end
})

vim.api.nvim_create_autocmd({ 'CursorMoved', 'ModeChanged' }, {
  callback = function(_)
    vim.g.ck_lsp_auto_highlight = true
    vim.lsp.buf.clear_references()
  end
})

-- Extensions

require('telescope').load_extension('undo')
vim.keymap.set("n", "<leader>u", "<cmd>Telescope undo<cr>")

require('telescope').load_extension('fzf')

require('telescope').load_extension('ui-select')
