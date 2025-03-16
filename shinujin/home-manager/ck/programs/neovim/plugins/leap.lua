local function map(mode, l, r, opts)
  opts = opts or {}
  opts.unique = true
  vim.keymap.set(mode, l, r, opts)
end

map({ 'n', 'x', 'o' }, 's', '<Plug>(leap)')
map({ 'n', 'x', 'o' }, 'S', '<Plug>(leap)')
