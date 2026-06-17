--
-- handled via either 'fzf lua' or 'snack'
-- uncomment the section below as needed
vim.pack.add {
  'https://github.com/goolord/alpha-nvim',
}

local ok, alpha = pcall(require, 'alpha')
if not ok then
  vim.notify('Plugin [Alpha] failed to load', vim.log.levels.WARN)
  return
end

local dashboard = require 'alpha.themes.dashboard'

dashboard.section.header.val = {
  [[                          (( _______           ]],
  [[                _______     /\O    O\          ]],
  [[               /O     /\   /  \      \         ]],
  [[              /   O  /O \ / O  \O____O\ ))     ]],
  [[          (( /_____O/    \\    /O     /        ]],
  [[             \O    O\    / \  /   O  /         ]],
  [[              \O    O\ O/   \/_____O/          ]],
  [[               \O____O\/ ))          ))        ]],
  [[             ((                                ]],
  [[                                               ]],
  [[  𝕯𝖔𝖓❜𝖙 𝖑𝖔𝖔𝖐 𝖇𝖆𝖈𝖐 𝖜𝖍𝖊𝖓 𝖙𝖍𝖊 𝖔𝖓𝖑𝖞 𝖈𝖔𝖚𝖗𝖘𝖊 𝖎𝖘 𝖋𝖔𝖗𝖜𝖆𝖗𝖉  ]],
}
dashboard.section.buttons.val = {
  dashboard.button('1', '📜 Fɪɴᴅ ғɪʟᴇs', "<cmd>lua require('snacks').picker.files()<cr>"),
  dashboard.button('2', '📁 Fɪɴᴅ ғᴏʟᴅᴇʀs', ':Yazi<CR>'),
  dashboard.button('3', '📝 Nᴇᴡ ғɪʟᴇ', ':ene!<CR>'),
  dashboard.button('4', '🔍 Fɪɴᴅ ᴛᴇxᴛ', "<cmd>lua require('snacks').picker.grep()<cr>"),
  dashboard.button('5', '📉 Rᴇᴄᴇɴᴛʟʏ ᴜsᴇᴅ ғɪʟᴇs', "<cmd>lua require('snacks').picker.recent()<cr>"),
  dashboard.button('6', '📑 Rᴇᴄᴇɴᴛ ᴘʀᴏᴊᴇᴄᴛs', "<cmd>lua require('snacks').picker.projects()<cr>"),
  dashboard.button('7', '🎨 Cʜᴀɴɢᴇ ᴄᴏʟᴏʀsᴄʜᴇᴍᴇ', "<cmd>lua require('snacks').picker.colorschemes()<cr>"),
  dashboard.button('8', '🧐 Lɪɴᴇs_Fʀᴏᴍ_Hɪsᴛᴏʀʏ', ':e ~/.config/nvim/lines_from_history.txt<CR>'),
  dashboard.button('9', '🔥 Uᴘᴅᴀᴛᴇ', ':lua vim.pack.update()<CR>'),
  dashboard.button('.', '💣 Qᴜɪᴛ', ':qa<CR>'),
}

-- FZF lua
-- dashboard.section.buttons.val = {
--   dashboard.button('1', '📜 Fɪɴᴅ ғɪʟᴇs', ':FzfLua files<CR>'),
--   dashboard.button('2', '📁 Fɪɴᴅ ғᴏʟᴅᴇʀs', ':Neotree float<CR>'),
--   dashboard.button('3', '📝 Nᴇᴡ ғɪʟᴇ', ':ene!<CR>'),
--   dashboard.button('4', '🔍 Fɪɴᴅ ᴛᴇxᴛ', ':FzfLua live_grep<CR>'),
--   dashboard.button('5', '📉 Rᴇᴄᴇɴᴛʟʏ ᴜsᴇᴅ ғɪʟᴇs', ':FzfLua oldfiles<CR>'),
--   dashboard.button('6', '📑 Rᴇᴄᴇɴᴛ ᴘʀᴏᴊᴇᴄᴛs', ':FzfLua resume<CR>'),
--   dashboard.button('7', '🎨 Cʜᴀɴɢᴇ ᴄᴏʟᴏʀsᴄʜᴇᴍᴇ', ':FzfLua colorscheme<CR>'),
--   dashboard.button('8', '🧐 Lɪɴᴇs_Fʀᴏᴍ_Hɪsᴛᴏʀʏ', ':e ~/.config/nvim/lines_from_history.txt<CR>'),
--   dashboard.button('9', '🔥 Uᴘᴅᴀᴛᴇ', ':lua vim.pack.update()<CR>'),
--   dashboard.button('.', '💣 Qᴜɪᴛ', ':qa<CR>'),
-- }

local version = vim.version()
local nvim_version_info = ('v%d.%d.%d'):format(version.major, version.minor, version.patch)

local datetime = os.date '📆 %d/%m/%Y ⏰ %H:%M:%S'

dashboard.section.footer.val = '│🔌 ' .. '  🧬 ' .. nvim_version_info .. '  ' .. datetime .. '│'

dashboard.section.footer.opts.hl = 'Type'
dashboard.section.header.opts.hl = 'Include'
dashboard.section.buttons.opts.hl = 'Keyword'
dashboard.opts.opts.noautocmd = true

alpha.setup(dashboard.opts)

if vim.bo.filetype == 'lazy' then
  vim.api.nvim_create_autocmd('WinClosed', {
    pattern = tostring(vim.api.nvim_get_current_win()),
    once = true,
    callback = function()
      vim.schedule(function() vim.api.nvim_exec_autocmds('UIEnter', {}) end)
    end,
  })
end
