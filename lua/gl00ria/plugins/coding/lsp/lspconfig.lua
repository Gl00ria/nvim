-- NOTE: since 'LSPInfo' has been removed use ':checkhealth vim.lsp' or better ':che lsp'
-- LSP provides Neovim with features like:
--  - Go to definition
--  - Find references
--  - Autocompletion
--  - Symbol Search
--  - and more!
-- config servers:
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
-- https://github.com/neovim/nvim-lspconfig/wiki/Language-specific-plugins
--

vim.pack.add { 'https://github.com/neovim/nvim-lspconfig' }

--  This function gets run when an LSP attaches to a particular buffer.
--    That is to say, every time a new file is opened that is associated with
--    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
--    function will be executed to configure the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(event)
    -- In this case, we create a function that lets us more easily define mappings specific
    -- for LSP related items. It sets the mode, buffer and description for us each time.
    local map = function(keys, func, desc, mode)
      mode = mode or 'n'
      vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
    end

    map('<leader>cK', vim.lsp.buf.hover, 'Hover')
    map('<leader>ck', vim.lsp.buf.signature_help, 'Singnatrue Help')

    map('<leader>cl', vim.lsp.codelens.run, 'Run Codelens')
    map('<leader>cL', vim.lsp.codelens.refresh, 'Refresh Codelens')

    -- Rename the variable under your cursor.
    map('<leader>cr', vim.lsp.buf.rename, 'Rename Variable [EVERY WHERE]')

    --
    -- When you move your cursor, the highlights will be cleared (the second autocommand).
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client:supports_method('textDocument/documentHighlight', event.buf) then
      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        buffer = event.buf,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        buffer = event.buf,
        callback = vim.lsp.buf.clear_references,
      })

      vim.api.nvim_create_autocmd('LspDetach', {
        callback = function(event2) vim.lsp.buf.clear_references() end,
      })
    end

    -- hanlded via @utils/snacks.lua
    -- if client and client:supports_method('textDocument/inlayHint', event.buf) then
    --   map('<leader>th', function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf }) end, '[T]oggle Inlay [H]ints')
    -- end
  end,
})

local icons = require('gl00ria.config.icons').kinds.diagnostic
local signs = {
  [vim.diagnostic.severity.ERROR] = icons.err,
  [vim.diagnostic.severity.WARN] = icons.warn,
  [vim.diagnostic.severity.HINT] = icons.hint,
  [vim.diagnostic.severity.INFO] = icons.info,
}

--  See `:help vim.diagnostic.Opts`
vim.diagnostic.config {
  signs = { text = signs },
  severity_sort = true,
  virtual_text = false,
  virtual_lines = false,
  -- underline = true, -- Always on
  underline = { severity = { min = vim.diagnostic.severity.WARN } },
  update_in_insert = false,
  float = {
    focusable = false,
    style = 'minimal',
    border = 'rounded',
    -- source = true,
    source = 'if_many',
  },
  -- Auto open the float, so you can easily read the errors when jumping with `[d` and `]d`
  jump = {
    on_jump = function(_, bufnr)
      vim.diagnostic.open_float {
        bufnr = bufnr,
        scope = 'cursor',
        focus = false,
      }
    end,
  },
}

--   map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
-- { "gd", vim.lsp.buf.definition, desc = "Goto Definition", has = "definition" },
-- { "gr", vim.lsp.buf.references, desc = "References", nowait = true },
-- { "gI", vim.lsp.buf.implementation, desc = "Goto Implementation" },
-- { "gy", vim.lsp.buf.type_definition, desc = "Goto T[y]pe Definition" },
-- { "gD", vim.lsp.buf.declaration, desc = "Goto Declaration" },
--   map('grn', vim.lsp.buf.rename, '[R]e[n]ame')
--   map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })
