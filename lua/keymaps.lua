local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap
-- local term_opts = { silent = true }

-- Modes
--   normal_mode = 'n'
--   insert_mode = 'i'
--   visual_mode = 'v'
--   visual_block_mode = 'x'
--   term_mode = 't'
--   command_mode = 'c'

--Remap space as leader key
keymap('', '<Space>', '<Nop>', opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Press jk/kj to exit Insert mode
keymap('i', 'jk', '<ESC>', opts)
keymap('i', 'kj', '<ESC>', opts)

-- Delete the buffer without a punch on my face
keymap('n', 'Q', '<cmd>Bdelete!<cr>', opts)

-- Search
keymap('v', '//', [[y/\V<C-R>=escape(@",'/\')<cr><cr>]], opts)

keymap('n', '<esc><esc>', '<cmd>nohlsearch<cr>', opts)

-- split window
-- keymap('n', '<C-\\>', '<cmd>vsplit<cr>', opts)


-- FFFFFs
keymap('n', '<F2>', '<cmd>Lspsaga rename<cr>', opts)
keymap('n', '<F3>', '<cmd>UndotreeToggle<cr>', opts)
keymap('n', '<F4>', '<cmd>Vista nvim_lsp<cr>', opts)
keymap('n', '<F5>', "<cmd>lua require('goto-preview').goto_preview_implementation()<cr>", opts)
keymap('n', '<F6>', "<cmd>lua require('goto-preview').goto_preview_definition()<cr>", opts)
keymap('n', '<F7>', "<cmd>lua require('goto-preview').goto_preview_references()<cr>", opts)
keymap('n', '<F8>', '<cmdTroubleToggle workspace_diagnostics<cr>', opts)
keymap('n', '<F9>', '<cmd>TroubleToggle document_diagnostics<cr>', opts)
keymap('n', 'q', "<cmd>lua require('goto-preview').close_all_win()<cr>", opts)

-- Enable transparent mode
keymap('n', '<F10>','<cmd>TransparentToggle<cr>', opts)

--     { "q", [[<cmd>TroubleToggle quickfix<cr>]] },
-- keymap('n', '', ':e ~/.config/nvim/lines_from_history.txt.txt/<cr>', opts)

-- Better windows navigation
keymap('n', '<C-h>', '<C-w>h', opts)
keymap('n', '<C-j>', '<C-w>j', opts)
keymap('n', '<C-k>', '<C-w>k', opts)
keymap('n', '<C-l>', '<C-w>l', opts)

-- Resize with arrows
keymap('n', '<C-Up>', '<cmd>resize -2<cr>', opts)
keymap('n', '<C-Down>', '<cmd>resize +2<cr>', opts)
keymap('n', '<C-Right>', '<cmd>vertical resize -2<cr>', opts)
keymap('n', '<C-Left>', '<cmd>vertical resize +2<cr>', opts)

-- Naviagate buffers
keymap('n', '<S-l>', '<cmd>bnext<cr>', opts)
keymap('n', '<S-h>', '<cmd>bprevious<cr>', opts)

-- Colorschemes
keymap('n', '11', '<cmd>colorscheme gruvbox<cr>', opts)
keymap('n', '22', '<cmd>colorscheme tokyonight<cr>', opts)
keymap('n', '33', '<cmd>colorscheme tokyodark<cr>', opts)
keymap('n', '44', '<cmd>colorscheme darkplus<cr>', opts)
keymap('n', '55', '<cmd>colorscheme doom-one<cr>', opts)
keymap('n', '66', '<cmd>colorscheme onedark<cr>', opts)
keymap('n', '77', '<cmd>colorscheme one_monokai<cr>', opts)
keymap('n', '88', '<cmd>colorscheme rose-pine<cr>', opts)
keymap('n', '99', '<cmd>colorscheme sonokai<cr>', opts)
keymap('n', '00', '<cmd>Telescope colorscheme<cr>', opts)


-- Move text up and down
keymap('x', 'J', ":move '>+1<cr>gv-gv", opts)
keymap('x', 'K', ":move '<-2<cr>gv-gv", opts)
keymap('x', '<A-j>', ":move '>+1<cr>gv-gv", opts)
keymap('x', '<A-k>', ":move '<-2<cr>gv-gv", opts)

-- indent block
keymap('x', '<Tab>', '>gv', opts)
keymap('x', '<S-Tab>', '<gv', opts)

-- Better terminal navigation
-- keymap('t', '<C-h>', '<C-\\><C-N><C-w>h', term_opts)
-- keymap('t', '<C-j>', '<C-\\><C-N><C-w>j', term_opts)
-- keymap('t', '<C-k>', '<C-\\><C-N><C-w>k', term_opts)
-- keymap('t', '<C-l>', '<C-\\><C-N><C-w>l', term_opts)

-- Spectre
keymap('n', 'sw', "<cmd>lua require('spectre').open_visual({select_word=true})<cr>", opts) -- search current word, 'normal_mode'
keymap('n', 'sf', "viw:lua require('spectre').open_file_search()<cr>", opts) -- search current file
keymap('v', 'vs', "<cmd>lua require('spectre').open_visual()<cr>", opts) -- search current word, 'visual_mode'
keymap('n', 'so', "<cmd>lua require('spectre').open()<cr>", opts)

-- LSPconfig
keymap('n', 'od', '<cmd>lua vim.diagnostic.open_float()<cr>', opts) -- Show diagnostic
keymap('n', 'nd', '<cmd>lua vim.diagnostic.goto_next()<cr>', opts) -- goto next diagnostic
keymap('n', 'pd', '<cmd>lua vim.diagnostic.goto_prev()<cr>', opts) -- gotto prev diagnostic
keymap('n', 'ld', '<cmd>lua vim.diagnostic.setloclist()<cr>', opts) -- list diagnostics
keymap('n', '<C-K>', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
keymap('n', 'ca', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
keymap('n', 'si', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
keymap('n', 'sh', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
keymap('n', 'af', '<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>', opts)
keymap('n', 'rf', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>', opts)
keymap('n', 'lf', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<cr>', opts)
keymap('n', 'sd', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)

-- Lspsaga
keymap('n', ',vt', '<cmd>Lspsaga toggle_virtual_text<cr>', opts)

-- ToggleTerm, see also 'whichkey.lua' for more options
keymap('n', '\\', '<cmd>ToggleTerm<cr>', opts)
keymap('n', 'f\\', '<cmd>ToggleTerm direction=float<cr>', opts) -- float
keymap('n', 'v\\', '<cmd>ToggleTerm size=90 direction=vertical<cr>', opts) -- vertical

-- Dial
keymap('n', '<C-I>', '<cmd>DialIncrement<cr>', opts)
keymap('n', '<C-D>', '<cmd>DialDecrement<cr>', opts)
