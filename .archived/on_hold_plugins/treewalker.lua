-- 'Treesitter' is a dep
vim.pack.add { 'https://github.com/aaronik/treewalker.nvim' }
require('treewalker').setup {}
-- require('which-key').add {
--   { mode = { 'n', 'v' }, '<C-j>', '<cmd>Treewalker Down<CR>', noremap = true, silent = false },
--   { mode = { 'n', 'v' }, '<C-k>', '<cmd>Treewalker Up<CR>', noremap = true, silent = false },
--   { mode = { 'n', 'v' }, '<C-h>', '<cmd>Treewalker Left<CR>', noremap = true, silent = false },
--   { mode = { 'n', 'v' }, '<C-l>', '<cmd>Treewalker Right<CR>', noremap = true, silent = false },
--   }
