-- Add/delete/replace surroundings (brackets, quotes, etc.)
--
-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
-- - sd'   - [S]urround [D]elete [']quotes
-- - sr)'  - [S]urround [R]eplace [)] [']
vim.pack.add { 'https://github.com/nvim-mini/mini.surround' }

local ok, mini_sur = pcall(require, 'mini.surround')
if ok then
  mini_sur.setup {
    mappings = {
      add = '<leader>as', -- Add surrounding in Normal and Visual modes
      delete = '<leader>ds', -- Delete surrounding
      replace = '<leader>cs', -- Replace surrounding
      find = 'gsf', -- Find surrounding (to the right)
      find_left = 'gsF', -- Find surrounding (to the left)
      highlight = 'gsh', -- Highlight surrounding
      update_n_lines = 'gsn', -- Update `n_lines`
    },
  }
else
  vim.notify('Failed to load plugin [Mini-Surround@Mini-Surround.lua]', vim.log.levels.ERROR)
end
