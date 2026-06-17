--
-- the menu that drops from the top
--
vim.pack.add { 'https://github.com/nvim-treesitter/nvim-treesitter-context' }
vim.api.nvim_create_autocmd({ 'BufReadPost' }, {
  callback = function()
    local ok, ts_context = pcall(require, 'treesitter-context')
    if ok then
      ts_context.setup {
        enable = true,
        multiwindow = true,
        line_numbers = vim.o.number or vim.o.relativenumber,
        multiline_threshold = 20,
      }

      local wk_ok, wk = pcall(require, 'which-key')
      if wk_ok then
        wk.add {
          { '[c', function() require('treesitter-context').go_to_context(vim.v.count1) end, silent = true, desc = 'Treesitter Next Context', icon = ' ' },
        }
      else
        vim.notify('Failed to load plugin [Which-key@ts-context.lua]', vim.log.levels.ERROR)
      end
    else
      vim.notify('Failed to load plugin [TS-Context@ts-context.lua]', vim.log.levels.ERROR)
    end
  end,
})
