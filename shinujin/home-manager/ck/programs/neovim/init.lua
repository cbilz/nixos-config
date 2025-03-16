vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true

vim.opt.list = true
vim.opt.lcs = "tab:  ,trail:~"
vim.opt.showbreak = ".."
vim.opt.fillchars = "fold: "

vim.opt.foldlevel = 99

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true

vim.opt.scrolloff = 5
vim.opt.signcolumn = "yes"

vim.opt.updatetime = 500

vim.opt.textwidth = 80
vim.opt.linebreak = true

vim.opt.diffopt = "internal,filler,closeoff,linematch:60,algorithm:histogram"

vim.opt.mouse = ""

vim.g.mapleader = " "
vim.g.maplocalleader = " "

local function map(mode, l, r, opts)
  opts = opts or {}
  opts.unique = true
  vim.keymap.set(mode, l, r, opts)
end

map("n", "<leader>v", vim.cmd.Ex)
map("n", "<leader><space>", function()
  vim.cmd.noh()
  vim.g.ck_lsp_auto_highlight = false
  vim.lsp.buf.clear_references()
end)
map('n', '<leader>cd', "<cmd>cd %:h<cr><cmd>pwd<cr>")

vim.api.nvim_create_autocmd('FileType', {
  callback = function(opts)
    local filetype = vim.bo[opts.buf].filetype
    if filetype == 'tex' then
      vim.opt.indentexpr = ''
      vim.opt.textwidth = 0
    elseif filetype == 'zig' then
      vim.opt_local.textwidth = 100
      vim.opt.colorcolumn = "101"
    elseif filetype == 'lua' then
      vim.opt_local.shiftwidth = 2
    end
  end,
})
