-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local keys_to_remove = {
  { "n", "<leader>l" }, -- :Lazy
  { "n", "<leader>sr" }, -- grug-far, set to F2
  { "v", "<leader>sr" }, -- grug-far, set to F2
  { "n", "<leader>sd" }, -- <cmd>FzfLua diagnostics_document<cr>, set to F6
  { "n", "<leader>sD" }, -- <cmd>FzfLua diagnostics_document<cr>, set to F7
  -- { "n", "<leader>w" }, -- side-tree --> snacks explorer
}

for _, key in ipairs(keys_to_remove) do
  vim.keymap.del(key[1], key[2])
end

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

-- Paste over selection
keymap("v", "<leader>p", '"_dP', { silent = true })

-- Don't yank on delete char
keymap("n", "x", '"_x', { silent = true })
keymap("n", "X", '"_X', { silent = true })
keymap("v", "x", '"_x', { silent = true })
keymap("v", "X", '"_X', { silent = true })

-- lines from history
keymap("n", "<leader>Fq", "<cmd>:e ~/.config/nvim/lines_from_history.txt<cr>", { desc = "Qutes" })

-- save file
-- map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })
keymap("n", "<C-a>", "ggVG", { silent = true }) -- select all
keymap("i", "<C-v>", "<C-r>+", { silent = true }) -- paste in insert mode

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
--  ╰───────────────────────────End───────────────────────────╯
-- ╭──────────────────────────────────────────────────────────╮
-- │                                                          │
-- │                        Buffers                           │
-- │                                                          │
-- ╰──────────────────────────────────────────────────────────╯

map("n", "<S-tab>", "<cmd>bprevious<cr>", { desc = "PREV Tab 󱠼 " })
map("n", "<Tab>", "<cmd>bnext<cr>", { desc = "NEXT Buffer 󰩵 " })

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
--  ╰───────────────────────────End───────────────────────────╯
-- ╭──────────────────────────────────────────────────────────╮
-- │                                                          │
-- │                         Coding                           │
-- │                                                          │
-- ╰──────────────────────────────────────────────────────────╯
-- formatting
map({ "n", "v" }, "<leader>cf", function()
  LazyVim.format({ force = true })
end, { desc = "LSP Format 󰉨 " })
-- diagnostic
local diagnostic_goto = function(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go({ severity = severity })
  end
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
--
-- stylua: ignore start

-- ╭──────────────────────────────────────────────────────────╮
-- │                                                          │
-- │                         Toggle                           │
-- │                                                          │
-- ╰──────────────────────────────────────────────────────────╯
LazyVim.format.snacks_toggle():map("<leader>uf")
LazyVim.format.snacks_toggle(true):map("<leader>uF")
Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
Snacks.toggle.diagnostics():map("<leader>ud")
Snacks.toggle.line_number():map("<leader>ul")
Snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2, name = "Conceal Level" }):map("<leader>uc")
Snacks.toggle.option("showtabline", { off = 0, on = vim.o.showtabline > 0 and vim.o.showtabline or 2, name = "Tabline" }):map("<leader>uA")
Snacks.toggle.treesitter():map("<leader>uT")
Snacks.toggle.option("background", { off = "light", on = "dark" , name = "Dark Background" }):map("<leader>ub")
Snacks.toggle.dim():map("<leader>uD")
Snacks.toggle.animate():map("<leader>ua")
Snacks.toggle.indent():map("<leader>ug")
Snacks.toggle.scroll():map("<leader>uS")
Snacks.toggle.profiler():map("<leader>dpp")
Snacks.toggle.profiler_highlights():map("<leader>dph")

if vim.lsp.inlay_hint then
  Snacks.toggle.inlay_hints():map("<leader>uh")
end

-- ╭──────────────────────────────────────────────────────────╮
-- │                                                          │
-- │                         Lazygit                          │
-- │                                                          │
-- ╰──────────────────────────────────────────────────────────╯
if vim.fn.executable("lazygit") == 1 then
  map("n", "<leader>gg", function() Snacks.lazygit( { cwd = LazyVim.root.git() }) end, { desc = "Lazygit (Root Dir)" })
  map("n", "<leader>gG", function() Snacks.lazygit() end, { desc = "Lazygit (cwd)" })
  map("n", "<leader>gf", function() Snacks.picker.git_log_file() end, { desc = "Git Current File History" })
  map("n", "<leader>gl", function() Snacks.picker.git_log({ cwd = LazyVim.root.git() }) end, { desc = "Git Log" })
  map("n", "<leader>gL", function() Snacks.picker.git_log() end, { desc = "Git Log (cwd)" })
end

map("n", "<leader>gb", function() Snacks.picker.git_log_line() end, { desc = "Git Blame Line" })
map({ "n", "x" }, "<leader>gB", function() Snacks.gitbrowse() end, { desc = "Git Browse (open)" })
map({"n", "x" }, "<leader>gY", function()
  Snacks.gitbrowse({ open = function(url) vim.fn.setreg("+", url) end, notify = false })
end, { desc = "Git Browse (copy)" })
