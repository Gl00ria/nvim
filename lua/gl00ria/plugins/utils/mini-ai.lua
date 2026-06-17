-- Better Around/Inside textobjects
vim.pack.add { 'https://github.com/echasnovski/mini.ai' }

local ok, mini_ai = pcall(require, 'mini.ai')
if ok then
  mini_ai.setup {
    -- Examples:
    --  - va)  - [V]isually select [A]round [)]paren
    --  - yiiq - [Y]ank [I]nside [I]+1 [Q]uote
    --  - ci'  - [C]hange [I]nside [']quote
    -- NOTE: Avoid conflicts with the built-in incremental selection mappings on Neovim>=0.12 (see `:help treesitter-incremental-selection`)
    mappings = {
      around_next = 'aa',
      inside_next = 'ii',
    },
    n_lines = 500,
  }
else
  vim.notify('Failed to load plugin [Mini-ai@mini-ai.lua]', vim.log.levels.ERROR)
end
