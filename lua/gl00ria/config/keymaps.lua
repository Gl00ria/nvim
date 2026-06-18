-- ╭──────────────────────────────────────────────────────────╮
-- │                                                          │
-- │                       Custom                             │
-- │                                                          │
-- ╰──────────────────────────────────────────────────────────╯

vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- -- disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- close folds
vim.keymap.set('n', '<leader>F', '<cmd>foldclose<cr>', { desc = 'Fold Close' })

-- <ESC>
vim.keymap.set('i', 'JK', '<ESC>', { silent = true })
vim.keymap.set('i', 'jk', '<ESC>', { silent = true })
vim.keymap.set('i', 'KJ', '<ESC>', { silent = true })
vim.keymap.set('i', 'kj', '<ESC>', { silent = true })

vim.keymap.set('n', '<C-s>', '<cmd>wall<cr>', { desc = 'Save all buffers', silent = true })
vim.keymap.set('n', '<C-q>', '<cmd>qall<cr>', { desc = 'Save + Quit Neovim', silent = true })

vim.keymap.set('n', '+', '<c-s-a>', { desc = 'Increment number under cursor', noremap = true })
vim.keymap.set('n', '-', '<c-s-x>', { desc = 'Decrement number under cursor', noremap = true })

-- TODO: remap 'which-key' --> not worky worky!! conflict? was working
vim.keymap.set('n', '<leader>rw', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/g<Left><Left>]], { desc = 'Replace word under cursor [All Buffer]' })

--  ╰───────────────────────────End───────────────────────────╯
-- ╭──────────────────────────────────────────────────────────╮
-- │                                                          │
-- │                        Lines                             │
-- │                                                          │
-- ╰──────────────────────────────────────────────────────────╯

vim.keymap.set({ 'n', 'v' }, 'H', '^', { desc = 'Move to the beginning of the line' })
vim.keymap.set({ 'n', 'v' }, 'L', '$', { desc = 'Move to the end of the line' })

-- Paste over selection
-- vim.keymap.set('v', '<leader>p', '"_dP', { silent = true })
vim.keymap.set('v', 'p', '"_dP', { silent = true })
vim.keymap.set('n', '<C-p>', 'viw"_dP', { desc = 'Paste over word without yanking' })
vim.keymap.set('i', '<C-v>', '<C-r>+', { silent = true }) -- paste in insert mode

-- Don't yank on delete char
vim.keymap.set('n', 'x', '"_x', { silent = true })
vim.keymap.set('n', 'X', '"_X', { silent = true })
vim.keymap.set('v', 'x', '"_x', { silent = true })
vim.keymap.set('v', 'X', '"_X', { silent = true })

vim.keymap.set('n', '<C-a>', 'ggVG', { silent = true }) -- select all
-- vim.keymap.set('n', '<C-c>', 'ciw') -- cut

-- move lines
vim.keymap.set('v', '<C-j>', ":m '>+1<cr>gv=gv", { desc = 'Move Selected Line Down' })
vim.keymap.set('v', '<C-k>', ":m '<-2<cr>gv=gv", { desc = 'Move Selected Line Up' })
-- ╭──────────────────────────────────────────────────────────╮
-- │                                                          │
-- │                         Window                           │
-- │                                                          │
-- ╰──────────────────────────────────────────────────────────╯

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--

-- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
-- vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
-- vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
-- vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
-- vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })

-- Move to window using the <ctrl> hjkl keys
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Go to Left Window', remap = true })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Go to Lower Window', remap = true })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Go to Upper Window', remap = true })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Go to Right Window', remap = true })
vim.keymap.set('n', '<leader>wo', '<C-W>p', { desc = 'Other Window   ', remap = true })

-- Resize window using <ctrl> arrow keys
vim.keymap.set('n', '<C-Up>', '<cmd>resize +2<cr>', { desc = 'Increase Window Height' })
vim.keymap.set('n', '<C-Down>', '<cmd>resize -2<cr>', { desc = 'Decrease Window Height' })
vim.keymap.set('n', '<C-Left>', '<cmd>vertical resize -2<cr>', { desc = 'Decrease Window Width' })
vim.keymap.set('n', '<C-Right>', '<cmd>vertical resize +2<cr>', { desc = 'Increase Window Width' })

-- window split
vim.keymap.set('n', '<leader>wj', '<C-W>s', { desc = 'Split Window Below 󰤻 ', remap = true })
vim.keymap.set('n', '<leader>wl', '<C-W>v', { desc = 'Split Window Right 󰤼 ', remap = true })
vim.keymap.set('n', '<leader>-', '<C-W>s', { desc = 'Split Window Below 󰤻 ', remap = true })
vim.keymap.set('n', '<leader>|', '<C-W>v', { desc = 'Split Window Right 󰤼 ', remap = true })
--  ╰───────────────────────────End───────────────────────────╯
-- ╭──────────────────────────────────────────────────────────╮
-- │                                                          │
-- │                        Buffers                           │
-- │                                                          │
-- ╰──────────────────────────────────────────────────────────╯

vim.keymap.set('n', '<S-tab>', '<cmd>bprevious<cr>', { desc = 'PREV Tab 󱠼 ' })
vim.keymap.set('n', '<Tab>', '<cmd>bnext<cr>', { desc = 'NEXT Buffer 󰩵 ' })

--  ╰───────────────────────────End───────────────────────────╯
-- ╭──────────────────────────────────────────────────────────╮
-- ╭──────────────────────────────────────────────────────────╮
-- │                                                          │
-- │                     Commenting                           │
-- │                                                          │
-- ╰──────────────────────────────────────────────────────────╯
-- credits: (https://www.reddit.com/r/neovim/comments/1d278fz/comment/l5zimt1/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button)
-- thin won't work in '.lua' files!!!
-- vim.keymap.set("n", "<leader>cc", ":normal gcc<CR>", { desc = "Toggle comment line" })
-- <Esc> - exists visual mode.
-- :normal executes keystrokes in normal mode.
-- gv - restores selection.
-- gc - toggles comment
-- <CR> sends the command
-- vim.keymap.set('v', '<leader>cc', '<Esc>:normal gvgc<CR>', { desc = 'Toggle comment block' })
vim.keymap.set('n', '<leader>aj', 'o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>', { desc = 'Comment Below 󰁅 ' })
vim.keymap.set('n', '<leader>ak', 'O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>', { desc = 'Comment Above 󰁝 ' })
--  ╰───────────────────────────End───────────────────────────╯
--  ╰───────────────────────────End───────────────────────────╯
-- ╭──────────────────────────────────────────────────────────╮
-- │                                                          │
-- │                         Coding                           │
-- │                                                          │
-- ╰──────────────────────────────────────────────────────────╯
-- ripped out from Lazyvim 'keymaps.lua'
-- https://github.com/LazyVim/LazyVim/blob/459a4c3b1059671e766a46c7cc223827dc67e3d0/lua/lazyvim/config/keymaps.lua#L125-L133
-- diagnostic
local diagnostic_goto = function(next, severity)
  return function()
    vim.diagnostic.jump {
      count = (next and 1 or -1) * vim.v.count1,
      severity = severity and vim.diagnostic.severity[severity] or nil,
      float = true,
    }
  end
end

vim.keymap.set('n', '<leader>cd', vim.diagnostic.open_float, { desc = 'Line Diagnostics' })
vim.keymap.set('n', ']d', diagnostic_goto(true), { desc = 'NEXT diagnostics  ' })
vim.keymap.set('n', '[d', diagnostic_goto(false), { desc = 'Prev Diagnostics  ' })
vim.keymap.set('n', ']e', diagnostic_goto(true, 'ERROR'), { desc = 'NEXT Error  ' })
vim.keymap.set('n', '[e', diagnostic_goto(false, 'ERROR'), { desc = 'PREV Error  ' })
vim.keymap.set('n', ']w', diagnostic_goto(true, 'WARN'), { desc = 'NEXT Warning  ' })
vim.keymap.set('n', '[w', diagnostic_goto(false, 'WARN'), { desc = 'PREV Warning  ' })
-- no need & mapped to 'next/prev hunk'
-- vim.keymap.set('n', ']h', diagnostic_goto(true, 'HINT'), { desc = 'NEXT Hint  ' })
-- vim.keymap.set('n', '[h', diagnostic_goto(false, 'HINT'), { desc = 'PREV Hint  ' })

-- this will override the above
local function get_highest_severity(count)
  local severity_order = {
    vim.diagnostic.severity.ERROR,
    vim.diagnostic.severity.WARN,
    vim.diagnostic.severity.INFO,
    vim.diagnostic.severity.HINT,
  }
  count = count or vim.diagnostic.count()

  for _, s in ipairs(severity_order) do
    if count[s] and count[s] > 0 then return s end
  end

  return nil
end
vim.keymap.set('n', ']d', function() vim.diagnostic.jump { count = vim.v.count1, severity = get_highest_severity() } end, {
  desc = 'Jump to the next diagnostic (prioritized)',
})

vim.keymap.set('n', '[d', function() vim.diagnostic.jump { count = vim.v.count1, severity = get_highest_severity() } end, {
  desc = 'Jump to the previous diagnostic (prioritized)',
})
--  ╰───────────────────────────End────────────────────────────╯
