vim.pack.add {
  'https://github.com/yetone/avante.nvim',
  --
  -- 'Plenary' & 'nui' --> already loaded in @/1st_load
  --
  -- 'https://github.com/nvim-lua/plenary.nvim',
  -- 'https://github.com/MunifTanjim/nui.nvim',

  --
  -- for file_selector provider
  -- pick one
  --
  -- 'https://github.com/nvim-mini/mini.pick',
  'https://github.com/ibhagwan/fzf-lua',
  'https://github.com/nvim-telescope/telescope.nvim',

  -- 'https://github.com/hrsh7th/nvim-cmp', -- autocomplete, 'blink.nvim' to be used

  --
  -- for input provider
  -- pick one
  --
  -- 'https://github.com/stevearc/dressing.nvim', -- archived!
  'https://github.com/folke/snacks.nvim',
}

local lazy = require 'gl00ria.config.lazy'
lazy.on_event('BufReadPost', function()
  local ok, avante = pcall(require, 'avante')
  if ok then
    avante.setup {
      input = { provider = 'snacks' },
      instructions_file = 'AGENTS.md',
      provider = 'opencode',
      windows = {
        width = 40,
      },
    }
  else
    vim.notify('Failed to load plugin [Avante@avante.lua]', vim.log.levels.ERROR)
  end
end, 'avante')
