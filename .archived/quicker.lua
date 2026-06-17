-- improved quick fix window
vim.pack.add { 'https://github.com/stevearc/quicker.nvim' }
require('quicker').setup {
  opts = {
    signcolumn = 'yes',
    winfixheight = true,
  },
  edit = {
    autosave = true,
  },
  follow = {
    enable = true,
  },
  -- Keymaps to set for the quickfix buffer
  keys = {
    {
      '>',
      function() require('quicker').expand { before = 2, after = 2, add_to_existing = true } end,
      desc = 'Expand quickfix context',
    },
    {
      '<',
      function() require('quicker').collapse() end,
      desc = 'Collapse quickfix context',
    },
  },
}
