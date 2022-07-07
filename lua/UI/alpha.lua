-- use a protected call so we don't error out on first use
local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
  return
end

local fn = vim.fn
local plugins_count = fn.len(vim.fn.globpath(fn.stdpath "data" .. "/site/pack/packer/start", "*", 0, 1))
local time = os.date("%H:%M:%S")
local  date = os.date("%d-%m-%Y")

local icons = require "icons"
local dashboard = require "alpha.themes.dashboard"

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
  dashboard.button( "1", icons.ui.FindFile .. " Fɪɴᴅ ғɪʟᴇ ", ":Telescope find_files <cr>" ),
  dashboard.button( "2", icons.ui.NewFile .. " Nᴇᴡ ғɪʟᴇ ", ":ene! <cr>" ),
  dashboard.button( "3", icons.ui.FindFolder .. " Fɪɴᴅ ғᴏʟᴅᴇʀs", ":RnvimrToggle <cr>" ),
  dashboard.button( "4", icons.ui.FindWord .. " Fɪɴᴅ ᴛᴇxᴛ", ":Telescope live_grep <cr>" ),
  dashboard.button( "5", icons.ui.History .. " Rᴇᴄᴇɴᴛʟʏ ᴜsᴇᴅ ғɪʟᴇs", ":Telescope oldfiles <cr>" ),
  dashboard.button( "6", icons.git.Repo .. " Rᴇᴄᴇɴᴛ ᴘʀᴏᴊᴇᴄᴛs", ":Telescope projects <cr>" ),
  dashboard.button( "7", icons.ui.ChangeColor .. " Cʜᴀɴɢᴇ ᴄᴏʟᴏʀsᴄʜᴇᴍᴇ", ":Telescope colorscheme <cr>" ),
  dashboard.button( "8", icons.ui.LinesHistory .. " Lɪɴᴇs_Fʀᴏᴍ_Hɪsᴛᴏʀʏ", ":e ~/.config/nvim/lines_from_history.txt <cr>" ),
  dashboard.button( "9", icons.ui.CloudDownload .. " Uᴘᴅᴀᴛᴇ", ":PackerSync<CR>"),
  dashboard.button( ".", icons.ui.Quitt .. " Qᴜɪᴛ", ":qa <cr>" ),
}

dashboard.section.footer.val = "[ "  .. plugins_count .. "] [ " .. time .. "] [ " .. date .. "]"
dashboard.section.footer.opts.hl = "Type"
dashboard.section.header.opts.hl = "Include"
dashboard.section.buttons.opts.hl = "Keyword"
dashboard.opts.opts.noautocmd = true
alpha.setup(dashboard.opts)
