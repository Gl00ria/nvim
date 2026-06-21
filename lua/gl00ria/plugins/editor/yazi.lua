vim.pack.add { 'https://github.com/mikavilpas/yazi.nvim' }

local lazy = require 'gl00ria.config.lazy'
lazy.on_event('BufReadPost', function()
  local ok, yazi = pcall(require, 'yazi')
  if ok then
  yazi.setup {
    keymaps = {
      show_help = '<f1>',
      open_file_in_horizontal_split = '<c-s>',
      grep_in_directory = false, -- attempts to use telescope
      close = 'q',
      open_file_in_tab = '<c-t>',
      replace_in_directory = '<c-g>',
      cycle_open_buffers = '<tab>',
      copy_relative_path_to_selected_files = '<c-y>',
      send_to_quickfix_list = '<c-q>',
      change_working_directory = '<c-\\>',
      open_and_pick_window = '<c-o>',
    },
  }

  local wk_ok, wk = pcall(require, 'which-key')
  if wk_ok then
    wk.add {
      {
        '<leader><space>',
        '<cmd>Yazi<cr>',
        desc = 'Awesome File Manager',
        icon = ' ',
      },
    }
  else
    vim.notify('Failed to load plugin [Which-key@yazi.lua]', vim.log.levels.ERROR)
  end
  else
    vim.notify('Failed to load plugin [Yazi@Yazi.lua]', vim.log.levels.ERROR)
  end
end, 'yazi')
