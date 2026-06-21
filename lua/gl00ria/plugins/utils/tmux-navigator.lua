vim.pack.add { 'https://github.com/aserowy/tmux.nvim' }
local lazy = require 'gl00ria.config.lazy'
lazy.on_event('BufReadPost', function()
  local ok, tmux = pcall(require, 'tmux')
  if ok then
    tmux.setup {
      copy_sync = {
        -- enables copy sync. by default, all registers are synchronized.
        -- to control which registers are synced, see the `sync_*` options.
        enable = false,

        -- overwrites vim.g.clipboard to redirect * and + to the system
        -- clipboard using tmux. If you sync your system clipboard without tmux,
        -- disable this option!
        sync_clipboard = true,
      },
      navigation = {

        -- enables default keybindings (C-hjkl) for normal mode
        enable_default_keybindings = true,

        -- prevents unzoom tmux when navigating beyond vim border
        persist_zoom = false,
      },
    }
  else
    vim.notify('Failed to load plugin [tmux@tmux-navigator.lua]', vim.log.levels.ERROR)
  end
end, 'tmux_navigator')
