-- kinda annoying, give it a test
vim.pack.add { 'https://github.com/okuuva/auto-save.nvim' }

vim.api.nvim_create_autocmd({ 'InsertLeave', 'TextChanged' }, {
  callback = function()
    require('auto-save').setup {
      -- noautocmd = true, -- Don't run autocmds, specifically Conform auto-format
      -- For when we e.g. `cdo` in quickfix
      write_all_buffers = true,
      debounce_delay = 200,
      condition = function() return not vim.g.disable_autosave end,
    }
  end,
})
