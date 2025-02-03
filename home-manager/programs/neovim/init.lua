vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<leader><space>", vim.cmd.noh)
vim.keymap.set('n', '<leader>cd', "<cmd>cd %:h<cr><cmd>pwd<cr>")

vim.opt.mouse = ""

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true

vim.opt.list = true
vim.opt.lcs="tab:  ,trail:~"
vim.opt.showbreak=".."
vim.opt.fillchars="fold: "

vim.opt.foldlevel=99

vim.opt.ignorecase=true
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

vim.opt.updatetime = 50

vim.opt.textwidth = 80
vim.opt.linebreak = true

vim.api.nvim_create_autocmd('FileType', {
    pattern = 'tex',
    callback = function()
        vim.opt.indentexpr = ''
        vim.opt.textwidth = 0
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "zig", callback = function()
        vim.opt_local.textwidth=100
        vim.opt.colorcolumn = "101"
        vim.keymap.set("n", "<leader>zf", function()
	    job = vim.fn.jobstart({"zig", "fmt", vim.fn.expand('%')}, {
                stdout_buffered = true,
            })
            if job >= 1 then
                vim.fn.jobwait({job}, 30000)
                vim.cmd.edit()
            end
        end)
    end
})
