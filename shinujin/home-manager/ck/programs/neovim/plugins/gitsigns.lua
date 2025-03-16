require('gitsigns').setup {
  signs = {
    add          = { text = '┃', show_count = false },
    change       = { text = '┃', show_count = false },
    delete       = { text = '_', show_count = true },
    topdelete    = { text = '‾', show_count = true },
    changedelete = { text = '~', show_count = true },
    untracked    = { text = '┆', show_count = false },
  },
  signs_staged = {
    add          = { text = '┃', show_count = false },
    change       = { text = '┃', show_count = false },
    delete       = { text = '_', show_count = true },
    topdelete    = { text = '‾', show_count = true },
    changedelete = { text = '~', show_count = true },
    untracked    = { text = '┆', show_count = false },
  },
  count_chars = { "₁", "₂", "₃", "₄", "₅", "₆", "₇", "₈", "₉", ["+"] = "₊" },
  attach_to_untracked = true,
  sign_priority = 20,
  max_file_length = 100000, -- Disable if file is longer than this (in lines)

  on_attach = function(bufnr)
    local gitsigns = require('gitsigns')

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', ']c', function()
      if vim.wo.diff then
        vim.cmd.normal({ ']c', bang = true })
      else
        gitsigns.nav_hunk('next', { greedy = false })
      end
    end)

    map('n', '[c', function()
      if vim.wo.diff then
        vim.cmd.normal({ '[c', bang = true })
      else
        gitsigns.nav_hunk('prev', { greedy = false })
      end
    end)

    -- Actions
    map('n', '<leader>hs', gitsigns.stage_hunk)
    map('n', '<leader>hu', gitsigns.undo_stage_hunk)
    map('n', '<leader>hr', gitsigns.reset_hunk)
    map('n', '<leader>hp', gitsigns.preview_hunk_inline)

    map('v', '<leader>hs', function()
      gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
    end)

    map('v', '<leader>hr', function()
      gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
    end)

    map('n', '<leader>hS', gitsigns.stage_buffer)
    map('n', '<leader>hR', gitsigns.reset_buffer)
    map('n', '<leader>hB', gitsigns.blame)

    map('n', '<leader>hb', function()
      gitsigns.blame_line({ full = true })
    end)

    map('n', '<leader>hl', gitsigns.setqflist)
    map('n', '<leader>hL', function() gitsigns.setqflist('all') end)

    -- Toggles
    map('n', '<leader>hd', gitsigns.toggle_deleted)
    map('n', '<leader>hw', gitsigns.toggle_word_diff)

    -- Text object
    map({ 'o', 'x' }, 'ih', gitsigns.select_hunk)
  end
}
