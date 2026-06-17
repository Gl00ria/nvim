vim.pack.add { 'https://github.com/NMAC427/guess-indent.nvim' }

vim.api.nvim_create_autocmd({ 'BufReadPost' }, {
  once = true,
  callback = function() require('guess-indent').setup {} end,
})
