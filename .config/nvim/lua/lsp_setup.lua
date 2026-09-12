-- Native LSP (nvim 0.11+). Replaces the unmaintained LanguageClient-neovim.
-- Server definitions live in ~/.config/nvim/lsp/<name>.lua and are enabled here.

vim.lsp.enable({ 'terraformls' })

-- Diagnostics: inline text, signs in the gutter, no noisy virtual lines.
vim.diagnostic.config({
  virtual_text = { spacing = 2, prefix = '●' },
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = { border = 'rounded', source = true },
})

-- Buffer-local keymaps, only where a server actually attached.
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('NcLspAttach', { clear = true }),
  callback = function(ev)
    local function map(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = ev.buf, silent = true, desc = desc })
    end

    -- nvim 0.11 already gives you: K (hover), grn (rename), gra (code action),
    -- grr (references), gri (implementation), gO (document symbols).
    -- These fill the gaps / match muscle memory.
    map('n', 'gd', vim.lsp.buf.definition, 'LSP: go to definition')
    map('n', 'gD', vim.lsp.buf.declaration, 'LSP: go to declaration')
    map('n', 'gy', vim.lsp.buf.type_definition, 'LSP: go to type definition')
    map('n', '<leader>e', vim.diagnostic.open_float, 'LSP: show diagnostic')
    map('n', '[d', function() vim.diagnostic.jump({ count = -1, float = true }) end, 'LSP: prev diagnostic')
    map('n', ']d', function() vim.diagnostic.jump({ count = 1, float = true }) end, 'LSP: next diagnostic')
    map('n', '<leader>lf', function() vim.lsp.buf.format({ async = true }) end, 'LSP: format buffer')

    -- Open definition in a new tab, mirroring the <C-\> ctags mapping.
    map('n', '<C-]>', function()
      vim.cmd('tab split')
      vim.lsp.buf.definition()
    end, 'LSP: definition in new tab')
  end,
})

-- :LspInfo equivalent without nvim-lspconfig.
vim.api.nvim_create_user_command('LspStatus', function()
  local clients = vim.lsp.get_clients({ bufnr = 0 })
  if #clients == 0 then
    print('No LSP client attached to this buffer (filetype: ' .. vim.bo.filetype .. ')')
    return
  end
  for _, c in ipairs(clients) do
    print(string.format('%s  (id %d)  root: %s', c.name, c.id, c.config.root_dir or 'n/a'))
  end
end, { desc = 'Show LSP clients attached to the current buffer' })
