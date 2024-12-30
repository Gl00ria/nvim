-- DO NOT USE `LazyVim.safe_keymap_set` IN YOUR OWN CONFIG!!
-- use `vim.keymap.set` instead
local map = LazyVim.safe_keymap_set
local keymap = vim.keymap.set

-- ╭──────────────────────────────────────────────────────────╮
-- │                                                          │
-- │                       Custom                             │
-- │                                                          │
-- ╰──────────────────────────────────────────────────────────╯
-- leave insert mode
keymap("i", "JK", "<ESC>", { silent = true })
keymap("i", "jk", "<ESC>", { silent = true })
keymap("i", "KJ", "<ESC>", { silent = true })
keymap("i", "kj", "<ESC>", { silent = true })

--
-- credit (https://www.reddit.com/r/neovim/s/2P50ksPcnd)
-- stylua: ignore start
map("x", "<leader>rw", ":s/\\(.*\\)/\\1<left><left><left><left><left><left><left><left><left>", { desc = "Replace word v/n mode", silent = false })
map("n", "<leader>rw", ":s/\\(.*\\)/\\1<left><left><left><left><left><left><left><left><left>", { desc = "Replace word v/n mode", silent = false })
-- replace visually selected word, or word under cursor
map("v", "<leader>ru", '"hy:%s/<C-r>h/<C-r>h/gc<left><left><left>', { desc = "Replace word under cursor v/n mode", silent = false })
map("n", "<leader>ru", ":%s/<C-r><C-w>/<C-r><C-w>/gcI<Left><Left><Left><Left>", { desc = "Replace word under cursor v/n mode", silent = false })
-- stylua: ignore stop

-- lazy plugins manager
map("n", "<leader>Pd", "<cmd>Lazy<cr>", { desc = "Lazy Dashboard" })
map("n", "<leader>Pe", "<cmd>LazyExtras<cr>", { desc = "Lazy Extras" })
-- LazyVim Changelog
map("n", "<leader>PL", function() LazyVim.news.changelog() end, { desc = "Lazy Changelog" })

-- Paste over selection
keymap("v", "<leader>p", '"_dP', { silent = true })

-- Don't yank on delete char
keymap("n", "x", '"_x', { silent = true })
keymap("n", "X", '"_X', { silent = true })
keymap("v", "x", '"_x', { silent = true })
keymap("v", "X", '"_X', { silent = true })

-- lines from history
keymap("n", "<leader>Fq", "<cmd>:e ~/.config/nvim/lines_from_history.txt<cr>", { desc = "Qutes" })

-- better up/down
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })

-- Add undo break-points
-- map("i", ",", ",<c-g>u")
-- map("i", ".", ".<c-g>u")
-- map("i", ";", ";<c-g>u")

-- save file
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })
keymap("n", "<C-a>", "ggVG", { silent = true }) -- select all
keymap("i", "<C-v>", "<C-r>+", { silent = true }) -- paste in insert mode
-- new file
map("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })

--keywordprg
map("n", "<leader>K", "<cmd>norm! K<cr>", { desc = "Keywordprg" })

-- better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- ╭──────────────────────────────────────────────────────────╮
-- │                                                          │
-- │                         Search                           │
-- │                                                          │
-- ╰──────────────────────────────────────────────────────────╯
-- Clear highlights with <esc>
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and Clear hlsearch" })

-- Clear search, diff update and redraw
-- taken from runtime/lua/_editor.lua
-- map(
--   "n",
--   "<leader>ur",
--   "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
--   { desc = "Redraw / Clear hlsearch / Diff Update" }
-- )

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next Search Result" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
map("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev Search Result" })
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })

--  ╰───────────────────────────End───────────────────────────╯
-- ╭──────────────────────────────────────────────────────────╮
-- │                                                          │
-- │                        Lines                             │
-- │                                                          │
-- ╰──────────────────────────────────────────────────────────╯
map("v", "<C-j>", ":m '>+1<cr>gv=gv", { desc = "Move Down" })
map("v", "<C-k>", ":m '<-2<cr>gv=gv", { desc = "Move Up" })
--
--  ╰───────────────────────────End───────────────────────────╯
-- ╭──────────────────────────────────────────────────────────╮
-- │                                                          │
-- │                         Window                           │
-- │                                                          │
-- ╰──────────────────────────────────────────────────────────╯

-- Move to window using the <ctrl> hjkl keys
map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })
map("n", "<leader>wo", "<C-W>p", { desc = "Other Window   ", remap = true })
-- map("n", "<leader>wd", "<C-W>c", { desc = "Delete Window", remap = true })

-- Resize window using <ctrl> arrow keys
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

-- window split
map("n", "<leader>wj", "<C-W>s", { desc = "Split Window Below 󰤻 ", remap = true })
map("n", "<leader>wl", "<C-W>v", { desc = "Split Window Right 󰤼 ", remap = true })
map("n", "<leader>-", "<C-W>s", { desc = "Split Window Below 󰤻 ", remap = true })
map("n", "<leader>|", "<C-W>v", { desc = "Split Window Right 󰤼 ", remap = true })
map("n", "<leader>wm", function() LazyVim.toggle.maximize() end, { desc = "Maximize Toggle 󱐪 " })
--  ╰───────────────────────────End───────────────────────────╯
-- ╭──────────────────────────────────────────────────────────╮
-- │                                                          │
-- │                        Buffers                           │
-- │                                                          │
-- ╰──────────────────────────────────────────────────────────╯
map("n", "<S-tab>", "<cmd>bprevious<cr>", { desc = "PREV Tab 󱠼 " })
map("n", "<Tab>", "<cmd>bnext<cr>", { desc = "NEXT Buffer 󰩵 " })
--
--  ╰───────────────────────────End────────────────────────────╯
-- ╭──────────────────────────────────────────────────────────╮
-- │                                                          │
-- │                           Tabs                           │
-- │                                                          │
-- ╰──────────────────────────────────────────────────────────╯
map("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last Tab" })
map("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First Tab" })

map("n", "<leader><tab>n", "<cmd>tabnew<cr>", { desc = "New Tab" })
map("n", "<leader><tab>l", "<cmd>tabnext<cr>", { desc = "Next Tab" })

map("n", "<leader><tab>c", "<cmd>tabclose<cr>", { desc = "Close Tab" })
map("n", "<leader><tab>h", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })

-- map("n", "<leader><tab>o", "<cmd>tabonly<cr>", { desc = "Close Other Tabs" })
--  ╰───────────────────────────End────────────────────────────╯
-- ╭──────────────────────────────────────────────────────────╮
-- │                                                          │
-- │                     Commenting                           │
-- │                                                          │
-- ╰──────────────────────────────────────────────────────────╯
-- credits: (https://www.reddit.com/r/neovim/comments/1d278fz/comment/l5zimt1/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button)
-- thin won't work in '.lua' files!!!
vim.keymap.set("n", "<leader>cc", ":normal gcc<CR>", { desc = "Toggle comment line" })
-- <Esc> - exists visual mode.
-- :normal executes keystrokes in normal mode.
-- gv - restores selection.
-- gc - toggles comment
-- <CR> sends the command
vim.keymap.set("v", "<leader>cc", "<Esc>:normal gvgc<CR>", { desc = "Toggle comment block" })
map("n", "<leader>aj", "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Comment Below 󰁅 " })
map("n", "<leader>ak", "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Comment Above 󰁝 " })
--  ╰───────────────────────────End────────────────────────────╯
-- ╭──────────────────────────────────────────────────────────╮
-- │                                                          │
-- │                     Quickfix/LocList                     │
-- │                                                          │
-- ╰──────────────────────────────────────────────────────────╯
--  replaced with 'trouble'
-- map("n", "<leader>xq", "<cmd>copen<cr>", { desc = "Quickfix List" })
-- map("n", "<leader>xl", "<cmd>lopen<cr>", { desc = "Location List" })
-- map("n", "[q", vim.cmd.cprev, { desc = "Previous Quickfix" })
-- map("n", "]q", vim.cmd.cnext, { desc = "Next Quickfix" })
--  ╰───────────────────────────End────────────────────────────╯
-- ╭──────────────────────────────────────────────────────────╮
-- │                                                          │
-- │                         Coding                           │
-- │                                                          │
-- ╰──────────────────────────────────────────────────────────╯
-- formatting
map({ "n", "v" }, "<leader>cf", function() LazyVim.format { force = true } end, { desc = "LSP Format 󰉨 " })
-- diagnostic
local diagnostic_goto = function(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function() go { severity = severity } end
end
map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
map("n", "]d", diagnostic_goto(true), { desc = "NEXT diagnostics  " })
map("n", "[d", diagnostic_goto(false), { desc = "Prev Diagnostics  " })
map("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "NEXT Error  " })
map("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "PREV Error  " })
map("n", "]w", diagnostic_goto(true, "WARN"), { desc = "NEXT Warning  " })
map("n", "[w", diagnostic_goto(false, "WARN"), { desc = "PREV Warning  " })
-- map("n", "]h", diagnostic_goto(true, "HINT"), { desc = "NEXT Hint  " })
-- map("n", "[h", diagnostic_goto(false, "HINT"), { desc = "PREV Hint  " })
--  ╰───────────────────────────End────────────────────────────╯
-- ╭──────────────────────────────────────────────────────────╮
-- │                                                          │
-- │                    Toggle keymaps                        │
-- │                                                          │
-- ╰──────────────────────────────────────────────────────────╯
-- stylua: ignore start

-- toggle options
map("n", "<leader>uf", function() LazyVim.format.toggle() end, { desc = "Toggle Auto Format (Global)" })
map("n", "<leader>uF", function() LazyVim.format.toggle(true) end, { desc = "Toggle Auto Format (Buffer)" })
map("n", "<leader>us", function() LazyVim.toggle("spell") end, { desc = "Toggle Spelling" })
map("n", "<leader>uw", function() LazyVim.toggle("wrap") end, { desc = "Toggle Word Wrap" })
map("n", "<leader>uL", function() LazyVim.toggle("relativenumber") end, { desc = "Toggle Relative Line Numbers" })
map("n", "<leader>ul", function() LazyVim.toggle.number() end, { desc = "Toggle Line Numbers" })
map("n", "<leader>ud", function() LazyVim.toggle.diagnostics() end, { desc = "Toggle Diagnostics" })
local conceallevel = vim.o.conceallevel > 0 and vim.o.conceallevel or 3
map("n", "<leader>uc", function() LazyVim.toggle("conceallevel", false, {0, conceallevel}) end, { desc = "Toggle Conceal" })
if vim.lsp.buf.inlay_hint or vim.lsp.inlay_hint then
  map( "n", "<leader>uh", function() LazyVim.toggle.inlay_hints() end, { desc = "Toggle Inlay Hints" })
end
map("n", "<leader>uT", function() if vim.b.ts_highlight then vim.treesitter.stop() else vim.treesitter.start() end end, { desc = "Toggle Treesitter Highlight" })
map("n", "<leader>ub", function() LazyVim.toggle("background", false, {"light", "dark"}) end, { desc = "Toggle Background" })
--  ╰───────────────────────────End───────────────────────────╯

-- lazygit
map("n", "<leader>gg", function() Snacks.lazygit( { cwd = LazyVim.root.git() }) end, { desc = "Lazygit (Root Dir)" })
map("n", "<leader>gG", function() Snacks.lazygit() end, { desc = "Lazygit (cwd)" })
-- map("n", "<leader>gb", Snacks.lazygit.blame_line, { desc = "Git Blame Line" })
map("n", "<leader>gB", Snacks.lazygit.browse, { desc = "Git Browse" })

map("n", "<leader>gf", function()
  local git_path = vim.api.nvim_buf_get_name(0)
  Snacks.lazygit({args = { "-f", vim.trim(git_path) }})
end, { desc = "Lazygit Current File History" })

map("n", "<leader>gl", function()
  Snacks.lazygit({ args = { "log" }, cwd = LazyVim.root.git() })
end, { desc = "Lazygit Log" })
map("n", "<leader>gL", function()
  Snacks.lazygit({ args = { "log" } })
end, { desc = "Lazygit Log (cwd)" })

-- quit
map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit All" })

-- highlights under cursor
map("n", "<leader>ui", vim.show_pos, { desc = "Inspect Pos" })
map("n", "<leader>uI", "<cmd>InspectTree<cr>", { desc = "Inspect Tree" })

-- floating terminal
local lazyterm = function() LazyVim.terminal(nil, { cwd = LazyVim.root() }) end
map("n", "<leader>ft", lazyterm, { desc = "Terminal (Root Dir)" })
map("n", "<leader>fT", function() LazyVim.terminal() end, { desc = "Terminal (cwd)" })
map("n", "<c-/>", lazyterm, { desc = "Terminal (Root Dir)" })
map("n", "<c-_>", lazyterm, { desc = "which_key_ignore" })

-- Terminal Mappings
map("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Enter Normal Mode" })
map("t", "<C-h>", "<cmd>wincmd h<cr>", { desc = "Go to Left Window" })
map("t", "<C-j>", "<cmd>wincmd j<cr>", { desc = "Go to Lower Window" })
map("t", "<C-k>", "<cmd>wincmd k<cr>", { desc = "Go to Upper Window" })
map("t", "<C-l>", "<cmd>wincmd l<cr>", { desc = "Go to Right Window" })
map("t", "<C-/>", "<cmd>close<cr>", { desc = "Hide Terminal" })
map("t", "<c-_>", "<cmd>close<cr>", { desc = "which_key_ignore" })
