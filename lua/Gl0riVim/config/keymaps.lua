local control_center_status, control_center = pcall(require, "control_center")
if not control_center_status then
  vim.notify("[settings] failed to load within (keymaps.lua)", vim.log.levels.WARN)
  return
end
local key = control_center.custom_keys

local util_status, Util = pcall(require, "util")
if not util_status then
  vim.notify("[Util] failed to load within (keymaps.lua)", vim.log.levels.WARN)
  return
end

local lazy_util_status, Info = pcall(require, "lazy.core.util")
if not lazy_util_status then
  vim.notify("[lazy.core.util] failed to load within (keymaps.lua)", vim.log.levels.WARN)
  return
end

local map = Util.map
local keymap = vim.keymap.set
local silent = { silent = true }
local expr_opts = { expr = true, silent = true }

-- ╭──────────────────────────────────────────────────────────╮
-- │                                                          │
-- │                       Custom                             │
-- │                                                          │
-- ╰──────────────────────────────────────────────────────────╯
-- ────────────── Leave insert mode
keymap("i", key.key_1, "<ESC>", silent)
keymap("i", key.key_2, "<ESC>", silent)
keymap("i", key.key_3, "<ESC>", silent)
keymap("i", key.key_4, "<ESC>", silent)

-- Del in normal mode
keymap("n", key.del_in_n_mode, "dh", silent)

-- Paste over selection
keymap("v", key.paste_over_selection, '"_dP', silent)

-- Don't yank on delete char
keymap("n", "x", '"_x', silent)
keymap("n", "X", '"_X', silent)
keymap("v", "x", '"_x', silent)
keymap("v", "X", '"_X', silent)

-- Remove highlights
keymap("n", key.remove_highlights, ":noh<CR><CR>", silent)

-- highlights under cursor
if vim.fn.has("nvim-0.9.0") == 1 then
  map("n", key.highlights_under_cursor, vim.show_pos, { desc = "Inspect Pos" })
end

-- Fun
map("n", key.lines_from_history, "<cmd>:e ~/.config/nvim/lines_from_history.txt<cr>", { desc = "Qutes" })

-- Options
map("n", key.options, "<cmd>options<cr>", { desc = "Options" })

-- ────────────── Better Navigation
-- UP
keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", expr_opts)
keymap("x", "j", "v:count == 0 ? 'gj' : 'j'", expr_opts)
-- Down
keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", expr_opts)
keymap("x", "k", "v:count == 0 ? 'gk' : 'k'", expr_opts)

-- ────────────── Save file --> ctrl + s
keymap("n", key.save_file, ":w<CR>", silent)
keymap("i", key.save_file, "<ESC> :w<CR>", silent)
-- ────────────── Select all --> ctrl + a
keymap("n", key.select_all, "ggVG", silent)
-- ────────────── Paste in insert mode --> ctrl + v
keymap("i", key.paste_in_i_mode, "<C-r>+", silent)

--  ╰───────────────────────────End───────────────────────────╯
-- ╭──────────────────────────────────────────────────────────╮
-- │                                                          │
-- │                    Plugin Manager                        │
-- │                                                          │
-- ╰──────────────────────────────────────────────────────────╯

map("n", key.lazy_dashboard, "<cmd>Lazy<cr>", { desc = "Lazy Dashboard" })
map("n", key.lazy_update, "<cmd>Lazy update<cr>", { desc = "Lazy Update" })
map("n", key.lazy_build, "<cmd>Lazy build<cr>", { desc = "Lazy Build" })
map("n", key.lazy_check, "<cmd>Lazy chekey<cr>", { desc = "Lazy Chekey" })
map("n", key.lazy_clean, "<cmd>Lazy clean<cr>", { desc = "Lazy Clear" })
map("n", key.lazy_debug, "<cmd>Lazy debug<cr>", { desc = "Lazy Debug" })
map("n", key.lazy_help, "<cmd>Lazy help<cr>", { desc = "Lazy Help" })
map("n", key.lazy_health, "<cmd>Lazy health<cr>", { desc = "Lazy Health" })
map("n", key.lazy_log, "<cmd>Lazy log<cr>", { desc = "Lazy Log" })
map("n", key.lazy_load, "<cmd>Lazy load<cr>", { desc = "Lazy load" })
map("n", key.lazy_profile, "<cmd>Lazy profile<cr>", { desc = "Lazy Profile" })
map("n", key.lazy_restore, "<cmd>Lazy restore<cr>", { desc = "Lazy Restore" })
map("n", key.lazy_reload, "<cmd>Lazy reload<cr>", { desc = "Lazy Reload" })
map("n", key.lazy_sync, "<cmd>Lazy sync<cr>", { desc = "Lazy Sync" })

--  ╰───────────────────────────End────────────────────────────╯
-- ╭──────────────────────────────────────────────────────────╮
-- │                                                          │
-- │                         Window                           │
-- │                                                          │
-- ╰──────────────────────────────────────────────────────────╯
keymap("n", key.w_nav_left, "<C-w>h", silent)
keymap("n", key.w_nav_down, "<C-w>j", silent)
keymap("n", key.w_nav_up, "<C-w>k", silent)
keymap("n", key.w_nav_right, "<C-w>l", silent)
map("n", key.w_goto_other, "<C-W>p", { desc = "Other window" })
map("n", key.w_delete, "<C-W>c", { desc = "Delete window" })
-- ────────────── Resize
map("n", key.w_resize_up, "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", key.w_resize_down, "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", key.w_resize_right, "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map("n", key.w_resize_left, "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })
-- ────────────── Split
map("n", key.w_split_below, "<C-W>s", { desc = "Split window below" }) -- "<leader>wj"
map("n", key.w_split_right, "<C-W>v", { desc = "Split window right" }) -- "<leader>wl"

--  ╰───────────────────────────End────────────────────────────╯
-- ╭──────────────────────────────────────────────────────────╮
-- │                                                          │
-- │                        Buffers                           │
-- │                                                          │
-- ╰──────────────────────────────────────────────────────────╯

keymap("n", key.next_buffer, ":bnext<CR>", silent)
keymap("n", key.prev_buffer, ":bprevious<CR>", silent)
keymap("n", key.close_all, ":update|%bd|e#|bd#<CR>", silent)

--  ╰───────────────────────────End────────────────────────────╯
-- ╭──────────────────────────────────────────────────────────╮
-- │                                                          │
-- │                           Tabs                           │
-- │                                                          │
-- ╰──────────────────────────────────────────────────────────╯

map("n", key.new_tab, "<cmd>tabnew<cr>", { desc = "New Tab" })
map("n", key.next_tab, "<cmd>tabnext<cr>", { desc = "Next Tab" })
map("n", key.prev_tab, "<cmd>tabprevious<cr>", { desc = "Previous Tab" })
map("n", key.close_tab, "<cmd>tabclose<cr>", { desc = "Close Tab" })

--  ╰───────────────────────────End────────────────────────────╯
-- ╭──────────────────────────────────────────────────────────╮
-- │                                                          │
-- │                        Lines                             │
-- │                                                          │
-- ╰──────────────────────────────────────────────────────────╯
-- ────────────── Move Up
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- ────────────── Move Down
map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })

-- ────────────── Indent
keymap("v", "<", "<gv", silent) -- left
keymap("v", ">", ">gv", silent) -- right

--  ╰───────────────────────────End────────────────────────────╯
-- ╭──────────────────────────────────────────────────────────╮
-- │                                                          │
-- │                         Search                           │
-- │                                                          │
-- ╰──────────────────────────────────────────────────────────╯
-- ( https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n )
-- ────────────── Next search result
-- keymap({ "n" }, "n", "'Nn'[v:searchforward].'zv'", expr_opts)
-- keymap({ "x", "o" }, "n", "'Nn'[v:searchforward]", expr_opts)

-- -- -- ────────────── Prev search result
-- keymap({ "n" }, "N", "'Nn'[v:searchforward].'zv'", expr_opts)
-- keymap({ "x", "o" }, "N", "'Nn'[v:searchforward]", expr_opts)

--  ╰───────────────────────────End───────────────────────────╯
-- ╭──────────────────────────────────────────────────────────╮
-- │                                                          │
-- │                    Toggle keymaps                        │
-- │                                                          │
-- ╰──────────────────────────────────────────────────────────╯

map("n", key.t_spelling, function()
  Util.toggle("spell")
end, { desc = "Toggle Spelling" })

map("n", key.t_wrap, function()
  Util.toggle("wrap")
end, { desc = "Toggle Word Wrap" })

map("n", key.t_line_num, function()
  Util.toggle("relativenumber", true)
  Util.toggle("number")
end, { desc = "Toggle Line Numbers" })

local conceallevel = vim.o.conceallevel > 0 and vim.o.conceallevel or 3
map("n", key.t_conceallevel, function()
  Util.toggle("conceallevel", false, { 0, conceallevel })
end, { desc = "Toggle Conceal" })

map("n", key.t_signcolumn, function()
  if vim.wo.signcolumn == "no" then
    vim.wo.signcolumn = "yes"
  elseif vim.wo.signcolumn == "yes" then
    vim.wo.signcolumn = "auto"
  else
    vim.wo.signcolumn = "no"
  end
  Info("Set signcolumn to " .. vim.wo.signcolumn, { title = "Option" })
end, { desc = "Toggle signcolumn" })

map("n", key.t_tabline, function()
  vim.opt.showtabline = vim.api.nvim_get_option("showtabline") == 0 and 2 or 0
  Info("Set showtabline to " .. vim.api.nvim_get_option("showtabline"), { title = "Option" })
end, { desc = "Toggle tabline" })

map("n", key.t_statusline, function()
  local laststatus = vim.api.nvim_get_option("laststatus")
  if laststatus == 0 then
    vim.opt.laststatus = 2
  elseif laststatus == 2 then
    vim.opt.laststatus = 3
  elseif laststatus == 3 then
    vim.opt.laststatus = 0
  end
  Info("Set laststatus to " .. vim.api.nvim_get_option("laststatus"), { title = "Option" })
end, { desc = "Toggle statusline" })

map("n", key.t_mouse, function()
  local mouse = vim.api.nvim_get_option("mouse")
  if mouse == "" then
    vim.opt.mouse = "nv"
    Info("Mouse Enabled: mouse = " .. vim.api.nvim_get_option("mouse"), { title = "Option" })
  else
    vim.opt.mouse = ""
    Info("Mouse Disabled", { title = "Option" })
  end
end, { desc = "Toggle mouse" })

map("n", key.t_number, function()
  local number = vim.wo.number -- local to window
  local relativenumber = vim.wo.relativenumber -- local to window
  if not number and not relativenumber then
    vim.wo.number = true
    Info("Set number to true", { title = "Option" })
  elseif number and not relativenumber then
    vim.wo.relativenumber = true
    Info("Set relativenumber to true", { title = "Option" })
  elseif number and relativenumber then
    vim.wo.number = false
    Info("Set number to false", { title = "Option" })
  else -- not number and relativenumber
    vim.wo.relativenumber = false
    Info("Set relativenumber to false", { title = "Option" })
  end
end, { desc = "Toggle number" })

map("n", key.t_colorcolumn, function()
  require("Gl0riVim.config.utils").toggle_colorcolumn()
end, { desc = "Toggle colorcolumn" })

-- Toggle Quikeylist
keymap("n", key.t_quicklist, function()
  require("Gl0riVim.config.utils").toggle_quikeylist()
end, silent)

-- credits: (https://www.reddit.com/r/neovim/comments/1d278fz/comment/l5zimt1/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button)
vim.keymap.set("n", "<leader>cc", ":normal gcc<CR>", { desc = "Toggle comment line" })
-- <Esc> - exists visual mode.
-- :normal executes keystrokes in normal mode.
-- gv - restores selection.
-- gc - toggles comment
-- <CR> sends the command
vim.keymap.set("v", "<leader>cc", "<Esc>:normal gvgc<CR>", { desc = "Toggle comment block" })

--  ╰───────────────────────────End───────────────────────────╯
