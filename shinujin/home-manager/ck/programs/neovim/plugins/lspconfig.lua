vim.keymap.set("n", "gd", vim.lsp.buf.definition)
vim.keymap.set("n", "ö", vim.lsp.buf.hover)
vim.keymap.set("n", "<leader>n", vim.lsp.buf.rename)
vim.keymap.set("n", "<leader>f", vim.lsp.buf.code_action)

vim.g.ck_format_on_write = 1

vim.api.nvim_create_autocmd('BufWritePre', {
  callback = function(opts)
    if vim.g.ck_format_on_write == 1 then
      local format = {
        zig = true,
        lua = true,
        nix = true,
      }
      if format[vim.bo[opts.buf].filetype] then
        vim.lsp.buf.format()
      end
    end
  end
})

--
-- clangd
--

require 'lspconfig'.clangd.setup {}

--
-- lua_ls
--

require 'lspconfig'.lua_ls.setup {
  on_init = function(client)
    if client.workspace_folders then
      local path = client.workspace_folders[1].name
      if vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc') then
        return
      end
    end

    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
      runtime = {
        version = 'LuaJIT'
      },
      workspace = {
        checkThirdParty = false,
        library = vim.api.nvim_get_runtime_file("", true)
      }
    })
  end,
  settings = {
    Lua = {}
  }
}

--
-- nixd
--

require 'lspconfig'.nixd.setup {}

--
-- ZLS
--

require 'lspconfig'.zls.setup {
  settings = {
    zls = {
      -- Whether to enable build-on-save diagnostics. Currently broken on NixOS.
      enable_build_on_save = true,

      -- Neovim already provides basic syntax highlighting
      semantic_tokens = "partial",
    }
  }
}
