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
[[  ๐ฏ๐๐โ๐ ๐๐๐๐ ๐๐๐๐ ๐๐๐๐ ๐๐๐ ๐๐๐๐ ๐๐๐๐๐๐ ๐๐ ๐๐๐๐๐๐๐  ]],
}

dashboard.section.buttons.val = {
  dashboard.button( "1", icons.ui.FindFile .. " Fษชษดแด าษชสแด ", ":Telescope find_files <cr>" ),
  dashboard.button( "2", icons.ui.NewFile .. " Nแดแดก าษชสแด ", ":ene! <cr>" ),
  dashboard.button( "3", icons.ui.FindFolder .. " Fษชษดแด าแดสแดแดสs", ":RnvimrToggle <cr>" ),
  dashboard.button( "4", icons.ui.FindWord .. " Fษชษดแด แดแดxแด", ":Telescope live_grep <cr>" ),
  dashboard.button( "5", icons.ui.History .. " Rแดแดแดษดแดสส แดsแดแด าษชสแดs", ":Telescope oldfiles <cr>" ),
  dashboard.button( "6", icons.git.Repo .. " Rแดแดแดษดแด แดสแดแดแดแดแดs", ":Telescope projects <cr>" ),
  dashboard.button( "7", icons.ui.ChangeColor .. " Cสแดษดษขแด แดแดสแดสsแดสแดแดแด", ":Telescope colorscheme <cr>" ),
  dashboard.button( "8", icons.ui.LinesHistory .. " Lษชษดแดs_Fสแดแด_Hษชsแดแดสส", ":e ~/.config/nvim/lines_from_history.txt <cr>" ),
  dashboard.button( "9", icons.ui.CloudDownload .. " Uแดแดแดแดแด", ":PackerSync<CR>"),
  dashboard.button( ".", icons.ui.Quitt .. " Qแดษชแด", ":qa <cr>" ),
}

dashboard.section.footer.val = "[๏ฆ "  .. plugins_count .. "] [๏ " .. time .. "] [๏ณ " .. date .. "]"
dashboard.section.footer.opts.hl = "Type"
dashboard.section.header.opts.hl = "Include"
dashboard.section.buttons.opts.hl = "Keyword"
dashboard.opts.opts.noautocmd = true
alpha.setup(dashboard.opts)
