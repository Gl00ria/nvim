-- Linting

vim.pack.add { 'https://github.com/mfussenegger/nvim-lint' }

local lazy = require 'gl00ria.config.lazy'
lazy.on_event('BufReadPost', function()
  local ok, lint = pcall(require, 'lint')
  if ok then
  require('lint').linters_by_ft = {
    -- markdown = { 'markdownlint' }, -- Make sure to install `markdownlint` via mason / npm
    markdown = { 'markdownlint-cli2' },

    cmake = { 'cmakelint' },
    php = { 'phpcs' },
    dockerfile = { 'hadolint' },
    go = { 'golangcilint' },
    text = { 'vale' },
    -- sql = { 'sqlfmt' }, -- handled by @conform.lua
  }

  -- You can disable the default linters by setting their filetypes to nil:
  -- lint.linters_by_ft['text'] = nil

  -- Create autocommand which carries out the actual linting
  -- on the specified events.
  local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
  vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
    group = lint_augroup,
    callback = function()
      -- Only run the linter in buffers that you can modify in order to
      -- avoid superfluous noise, notably within the handy LSP pop-ups that
      -- describe the hovered symbol using Markdown.
      if vim.bo.modifiable then lint.try_lint() end
    end,
  })
  else
    vim.notify('Failed to load plugin [nvim-lint@lint.lua]', vim.log.levels.ERROR)
  end
end, 'lint')
