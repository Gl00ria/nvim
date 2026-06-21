-- [[ Formatting ]]
vim.pack.add { 'https://github.com/stevearc/conform.nvim' }
local lazy = require 'gl00ria.config.lazy'
lazy.on_event('BufReadPost', function()
  local ok, conform = pcall(require, 'conform')
  if ok then
  conform.setup {
    notify_on_error = true,
    format_on_save = {
      -- These options will be passed to conform.format()
      timeout_ms = 500,
      lsp_format = 'fallback',
    },
    default_format_opts = {
      lsp_format = 'fallback', -- Use external formatters if configured below, otherwise use LSP formatting. Set to `false` to disable LSP formatting entirely.
    },
    -- You can also specify external formatters in here.
    formatters_by_ft = {
      lua = { 'stylua' },

      -- python = { 'black', lsp_format = 'fallback', stop_after_first = true },
      python = { 'ruff' },

      -- Ruby
      ruby = { 'rubocop' },
      eruby = { 'erb_format' },

      php = { 'php-cs-fixer' },

      -- dotnet / c#
      cs = { 'csharpier' },
      fsharp = { 'fantomas' },

      javascript = { 'prettierd', lsp_format = 'fallback', stop_after_first = true },
      typescript = { 'prettierd', lsp_format = 'fallback', stop_after_first = true },
      javascriptreact = { 'prettierd', lsp_format = 'fallback', stop_after_first = true },
      typescriptreact = { 'prettierd', lsp_format = 'fallback', stop_after_first = true },
      html = { 'prettierd', lsp_format = 'fallback', stop_after_first = true },
      terraform = { lsp_format = 'always', stop_after_first = true },

      markdown = { 'prettier', 'markdownlint-cli2', 'markdown-toc' },
      -- markdown = { 'prettierd', lsp_format = 'fallback', stop_after_first = true },

      css = { 'prettier' },
      scss = { 'prettier' },
      yaml = { 'prettier' },

      go = { 'goimports', 'gofumpt' },

      json = { 'prettier' },

      sql = { 'sqlfmt', lsp_format = 'never', stop_after_first = true },

      -- You can use 'stop_after_first' to run the first available formatter from the list
      -- javascript = { "prettierd", "prettier", stop_after_first = true },
    },

    formatters = {
      ['markdown-toc'] = {
        condition = function(_, ctx)
          for _, line in ipairs(vim.api.nvim_buf_get_lines(ctx.buf, 0, -1, false)) do
            if line:find '<!%-%- toc %-%->' then return true end
          end
        end,
      },
      ['markdownlint-cli2'] = {
        condition = function(_, ctx)
          local diag = vim.tbl_filter(function(d) return d.source == 'markdownlint' end, vim.diagnostic.get(ctx.buf))
          return #diag > 0
        end,
      },
      ['php-cs-fixer'] = {
        command = 'php-cs-fixer',
        args = {
          'fix',
          '--rules=@PSR12', -- Formatting preset. Other presets are available, see the php-cs-fixer docs.
          '$FILENAME',
        },
        stdin = false,
      },
    },
  }

  -- TODO: remap 'which-key'
  vim.keymap.set({ 'n', 'v' }, '<leader>f', function() require('conform').format { async = true } end, { desc = '[F]ormat buffer' })
  else
    vim.notify('Failed to load plugin [Conform@conform.lua]', vim.log.levels.ERROR)
  end
end, 'conform')
