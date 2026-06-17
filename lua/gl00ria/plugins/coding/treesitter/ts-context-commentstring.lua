vim.pack.add { 'https://github.com/JoosepAlviste/nvim-ts-context-commentstring' }

vim.api.nvim_create_autocmd({ 'BufReadPost' }, {
  callback = function()
    local ok, ts_commentstring = pcall(require, 'ts_context_commentstring')
    if ok then
      ts_commentstring.setup {
        enable_autocmd = false,
      }

      local get_option = vim.filetype.get_option
      vim.filetype.get_option = function(filetype, option)
        return option == 'commentstring' and require('ts_context_commentstring.internal').calculate_commentstring() or get_option(filetype, option)
      end
    else
      vim.notify('Failed to load plugin [ts_commentstring@ts-context-commentstring.lua]', vim.log.levels.ERROR)
    end
  end,
})
