-- Alt: (https://github.com/akinsho/bufferline.nvim)
-- show oppened tabs
-- NOTE: no need to keymap, already mapped @keymaps.lua
--
vim.pack.add { 'https://github.com/romgrk/barbar.nvim' }

local ok, barbar = pcall(require, 'barbar')
if ok then
  vim.g.barbar_auto_setup = false -- disable auto-setup

  barbar.setup {
    -- Enable/disable animations
    animation = true,

    icons = {
      button = '',
      -- Enables / disables diagnostic symbols
      diagnostics = {
        [vim.diagnostic.severity.ERROR] = { enabled = true },
        [vim.diagnostic.severity.WARN] = { enabled = true },
        [vim.diagnostic.severity.INFO] = { enabled = false },
        [vim.diagnostic.severity.HINT] = { enabled = false },
      },
      gitsigns = {
        added = { enabled = false, icon = '+' },
        changed = { enabled = false, icon = '~' },
        deleted = { enabled = false, icon = '-' },
      },
      -- Supports all the base icon options.
      modified = { button = '●' },
      pinned = { button = '', filename = true },

      -- Use a preconfigured buffer appearance— can be 'default', 'powerline', or 'slanted'
      preset = 'default',
    },

    sidebar_filetypes = {
      -- Use the default values: {event = 'BufWinLeave', text = '', align = 'left'}
      NvimTree = true,
      -- Or, specify the text used for the offset:
      undotree = {
        text = 'undotree',
        align = 'center', -- *optionally* specify an alignment (either 'left', 'center', or 'right')
      },
      -- Or, specify the event which the sidebar executes when leaving:
      ['neo-tree'] = { event = 'BufWipeout' },
      -- Or, specify all three
      Outline = { event = 'BufWinLeave', text = 'symbols-outline', align = 'right' },
    },
  }
else
  vim.notify('Failed to load plugin [Barbar@barbar.lua]', vim.log.levels.ERROR)
end
