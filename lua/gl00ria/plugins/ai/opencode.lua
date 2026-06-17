-- TIP: no need to call 'setup()'
vim.pack.add {
  {
    src = 'https://github.com/nickjvandyke/opencode.nvim',
    version = vim.version.range '*',
  },
}

local wk_ok, wk = pcall(require, 'which-key')
if wk_ok then
  wk.add {
    { mode = { 'n', 'x' }, '<leader>oa', function() require('opencode').ask '@this: ' end, desc = 'Ask @this line', icon = '󱜙 ' },
    { mode = { 'n', 'x' }, '<leader>os', function() require('opencode').select() end, desc = 'Ask Selected', icon = '󱜙 ' },
  }
else
  vim.notify('Failed to load plugin [Which-key@opencode.lua]', vim.log.levels.ERROR)
end

-- vim.keymap.set({ 'n', 'x' }, 'go', function() return require('opencode').operator '@this ' end, { desc = 'Append range to OpenCode', expr = true })
-- vim.keymap.set('n', 'goo', function() return require('opencode').operator '@this ' .. '_' end, { desc = 'Append line to OpenCode', expr = true })
-- vim.keymap.set('n', '<S-C-u>', function() require('opencode').command 'session.half.page.up' end, { desc = 'Scroll OpenCode up' })
-- vim.keymap.set('n', '<S-C-d>', function() require('opencode').command 'session.half.page.down' end, { desc = 'Scroll OpenCode down' })
