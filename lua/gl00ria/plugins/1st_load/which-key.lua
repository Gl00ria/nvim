--
-- display keybinds
--
vim.pack.add { 'https://github.com/folke/which-key.nvim' }

local ok, wk = pcall(require, 'which-key')
if ok then
  wk.setup {
    ---@type false | "classic" | "modern" | "helix"
    preset = 'helix',
    -- Delay between pressing a key and opening which-key (milliseconds)
    delay = 0,
    icons = { mappings = vim.g.have_nerd_font },

    spec = {
      -- <F1> --> @utils/snacks.lua --> find keymaps
      -- <F2> --> @utils/search-replace.lua
      -- <F3> --> @utils/snacks.lua --> undotree
      -- <F5> --> @coding/trouble.lua --> diagnostics
      -- <F5> --> @coding/trouble.lua --> diagnostics
      -- <F6> --> @coding/outline.lua
      { '<leader>/', group = 'Todo Comments', icon = ' ' }, -- @ui/todo-comments.lua

      { '<leader><space>', group = 'Awesome File Manager', icon = ' ' }, --@editor/yazi.lua

      { '<leader>a', group = '[A]dd', icon = ' ' }, -- @coding/annotation.lua
      { '<leader>A', group = '[A]nnotation', icon = '󰙆 ' }, -- @coding/annotation.lua

      { '<leader>b', group = '[B]uffers', icon = ' ' }, -- @utils/snacks.lua
      { '<leader>bd', group = '[D]elete', icon = '󱂥 ' }, -- @utils/snacks.lua

      { '<leader>c', group = '[C]odding', icon = ' ' }, -- @utils/snacks.lua
      -- '<leader>ca' --> @ui/tiny-code-action.lua
      -- '<leader>cK' --> @coding/lspconfig.lua --> Hover
      -- '<leader>ck' --> @coding/lspconfig.lua --> Signature Help
      -- '<leader>cl' --> @coding/lspconfig.lua --> Codelens
      -- '<leader>cL' --> @coding/lspconfig.lua --> Codelens Refresh
      -- '<leader>cr' --> @coding/lspconfig.lua --> Rename Variable under cursor
      { '<leader>d', group = '[D]elete', icon = ' ' },

      -- @editor/neo-tree
      { '<leader>e', function() require('neo-tree.command').execute { toggle = true } end, desc = 'Toggle File Explorer', icon = '󱇒' },

      { '<leader>F', group = 'Fold Close', icon = ' ' }, -- @config/keymaps.lua
      { '<leader>f', group = '[F]ind', icon = '󰛔 ' },

      { '<leader>g', group = 'Git', icon = ' ' }, -- @utils/git/mini-diff.lua
      -- { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } }, -- Enable gitsigns recommended keymaps first

      -- @ai/opencode.lua
      { '<leader>o', group = 'OpenCode', icon = '󱜙  ' },

      { '<leader>r', group = '[R]eplace', icon = ' ' },
      -- <leader>rw --> replace word under cursor @keymaps.lua

      -- @editor/snacks
      -- '<leader>n' --> notifications
      { '<leader>s', group = '[S]earch', icon = '󰜏 ' }, --> search
      { '<leader>t', group = '[T]oggle', icon = ' ' }, --> toggle

      { '<leader>w', group = '[W]window', icon = ' ' }, --> toggle

      -- <leader>z --> taken by '@snacks.lua' Zen Mode

      { 'g', group = 'LSP', icon = '󰿘 ' },
      { 'gr', group = 'LSP Actions', mode = { 'n' } },

      -- { '<leader>q', group = '[Q]uick' },
      -- { '<leader>qf', group = 'Quickfix' },
      -- { '<leader>ql', group = 'Loclist' },
    },
  }
else
  vim.notify('Failed to load plugin [Which-key@which-key.lua]', vim.log.levels.ERROR)
end
