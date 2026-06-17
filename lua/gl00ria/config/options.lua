-- Enable faster startup by caching compiled Lua modules
vim.loader.enable()

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

--  See `:help vim.o`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- Make line numbers default
vim.o.number = true
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
vim.o.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.o.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.o.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function() vim.o.clipboard = 'unnamedplus' end)

-- Enable break indent
vim.o.breakindent = true
vim.o.copyindent = true
vim.o.linebreak = true
vim.o.showbreak = '↪'

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.o.signcolumn = 'yes'
vim.o.number = true

-- Decrease update time
vim.o.updatetime = 250

-- Decrease mapped sequence wait time
vim.o.timeoutlen = 300

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.splitkeep = 'screen' -- for focus.nvim; otherwise screen

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
--
--  Notice listchars is set using `vim.opt` instead of `vim.o`.
--  It is very similar to `vim.o` but offers an interface for conveniently interacting with tables.
--   See `:help lua-options`
--   and `:help lua-guide-options`
vim.opt.list = true
vim.opt.listchars = {
  tab = '» ',
  trail = '·',
  nbsp = '␣',
}

vim.opt.fillchars = {
  eob = ' ',
  lastline = ' ',
  fold = ' ',
}

-- Preview substitutions live, as you type!
vim.o.inccommand = 'split'

-- Show which line your cursor is on
vim.o.cursorline = true
vim.o.cursorlineopt = 'both'
vim.opt.guicursor:append 't:ver25'

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 10
vim.o.sidescrolloff = 10

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.o.confirm = true

vim.o.winborder = 'rounded'

vim.o.spelllang = 'en'
vim.o.spelloptions = 'noplainbuffer'

vim.g.winblend_default = 0 --20

-- Don't show the mode, since it's already in the status line
vim.o.showmode = false

vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true

-- backup & undo
vim.o.swapfile = false
vim.o.autowrite = true
vim.o.autowriteall = true
vim.o.autoread = true
-- lua print(vim.o.undodir)
vim.o.undodir = vim.fn.expand '~/.custom_db/nvim/plugins/undotree'
vim.o.undofile = true

vim.o.cmdheight = 0

vim.opt.wrap = false

vim.opt.termguicolors = true

vim.opt.foldmethod = 'expr' -- Define folds using an expression
vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()' -- Use Treesitter for folding
vim.opt.foldlevelstart = 99
vim.opt.foldtext = '' -- Syntax highlight first line of fold
-- vim.api.nvim_create_autocmd('BufNew', {
--   pattern = '*',
--   callback = function()
--     -- Move cursor back and forth to open whatever fold it's in, if any
--     vim.api.nvim_feedkeys('hl', 'n', false)
--   end,
-- })

vim.o.laststatus = 3

vim.api.nvim_command 'aunmenu PopUp.How-to\\ disable\\ mouse'
vim.api.nvim_command 'aunmenu PopUp.-1-'
