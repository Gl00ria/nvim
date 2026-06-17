vim.pack.add { 'https://github.com/nvim-treesitter/nvim-treesitter-textobjects' }

vim.api.nvim_create_autocmd({ 'BufReadPost' }, {
  callback = function()
    local ok, ts_txt_objs = pcall(require, 'nvim-treesitter-textobjects')
    if ok then
      ts_txt_objs.setup {}

      local wk_ok, wk = pcall(require, 'which-key')
      if wk_ok then
        wk.add {
          {
            'fo',
            mode = { 'o', 'x' },
            function() require('nvim-treesitter-textobjects.select').select_textobject('@function.outer', 'textobjects') end,
            desc = 'Select Outer Function',
          },
          {
            'fi',
            mode = { 'o', 'x' },
            function() require('nvim-treesitter-textobjects.select').select_textobject('@function.inner', 'textobjects') end,
            desc = 'Select Inner Function',
          },
          {
            'co',
            mode = { 'o', 'x' },
            function() require('nvim-treesitter-textobjects.select').select_textobject('@class.outer', 'textobjects') end,
            desc = 'Select Outer Function',
          },
          {
            'ci',
            mode = { 'o', 'x' },
            function() require('nvim-treesitter-textobjects.select').select_textobject('@class.inner', 'textobjects') end,
            desc = 'Select Inner Function',
          },
        }
      else
        vim.notify('Failed to load plugin [Which-key@ts-textobjects.lua]', vim.log.levels.ERROR)
      end
    else
      vim.notify('Failed to load plugin [TS-textojcetcs@ts-textobjects.lua]', vim.log.levels.ERROR)
    end
  end,
})
