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

local function map(mode, l, r, opts)
  opts = opts or {}
  opts.unique = true
  vim.keymap.set(mode, l, r, opts)
end

local builtin = require('telescope.builtin')

map('n', '<leader>t', builtin.resume)
map('n', '<leader>T', builtin.pickers)

map('n', '<leader>f', builtin.find_files)
map('n', '<leader>F', builtin.git_files)
map('n', '<leader>s', builtin.live_grep)
map('n', '<leader>m', builtin.grep_string)
map('n', '<leader>b', builtin.buffers)
map('n', '<leader>x', builtin.command_history)
map('n', '<leader>X', builtin.commands)
map('n', '<leader>h', builtin.search_history)
map('n', '<leader>k', builtin.marks)

map('n', '<leader>r', builtin.lsp_references)
map('n', '<leader>l', builtin.lsp_document_symbols)
map('n', '<leader>g', builtin.diagnostics)
map('n', 'gt', builtin.lsp_type_definitions)

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
map("n", "<leader>u", "<cmd>Telescope undo<cr>")

require('telescope').load_extension('fzf')

require('telescope').load_extension('ui-select')
