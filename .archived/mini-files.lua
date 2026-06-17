vim.pack.add { 'https://github.com/echasnovski/mini.files' }

require('mini.files').setup()

require('which-key').add {
  {
    '\\',
    function() require('mini.files').open(vim.api.nvim_buf_get_name(0)) end,
    desc = 'Open Mini Files',
  },
}
