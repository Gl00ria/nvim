local fn = vim.fn
local plugins_count = fn.len(vim.fn.globpath(fn.stdpath "data" .. "/site/pack/packer/start", "*", 0, 1))
local time = os.date("%H:%M:%S")
local  date = os.date("%d-%m-%Y")


vim.g.dashboard_default_executive = 'telescope'
vim.g.dashboard_disable_statusline = 1
vim.g.dashboard_custom_header = {

[[                          (( _______           ]],
[[                _______     /\O    O\          ]],
[[               /O     /\   /  \      \         ]],
[[              /   O  /O \ / O  \O____O\ ))     ]],
[[          (( /_____O/    \\    /O     /        ]],
[[             \O    O\    / \  /   O  /         ]],
[[              \O    O\ O/   \/_____O/          ]],
[[               \O____O\/ ))          ))        ]],
[[             ((                                ]],
[[                                                     ]],
[[    𝔇𝔬𝔫'𝔱 𝔩𝔬𝔬𝔨 𝔟𝔞𝔠𝔨 𝔴𝔥𝔢𝔫 𝔱𝔥𝔢 𝔬𝔫𝔩𝔶 𝔠𝔬𝔲𝔯𝔰𝔢 𝔦𝔰 𝔣𝔬𝔯𝔴𝔞𝔯𝔡  ]],
}

vim.g.dashboard_custom_footer = {
    " ",
   "[ "  .. plugins_count .. " plugins  ] [ " .. time .. "] [ " .. date .. "]",
}

-- vim.g.dashboard_custom_shortcut = {
--
--   last_session       = 'SPC s l',
--   find_history       = 'SPC f h',
--   find_file          ='SPC f f',
--   new_file           = 'SPC c n',
--   change_colorscheme = 'SPC t c',
--   find_word          = 'SPC f a',
--   book_marks         = 'SPC f b',
-- }

vim.g.dashboard_custom_section = {
  a = {
    description = { "ﮛ  𝓕𝓲𝓷𝓭 𝓕𝓸𝓵𝓭𝓮𝓻        " },
    command = "RnvimrToggle",
  },
  b = {
    description = { "  𝓕𝓲𝓷𝓭 𝓕𝓲𝓵𝓮          " },
    command = "Telescope find_files",
  },
  c = {
    description = { "  𝓕𝓲𝓷𝓭 𝓦𝓸𝓻𝓭          " },
    command = "Telescope live_grep",
  },
  d = {
    description = { "  𝓝𝓮𝔀 𝓕𝓲𝓵𝓮           " },
    command = ":ene!",
  },
  e = {
    description = { "  𝓡𝓮𝓬𝓮𝓷𝓽𝓵𝔂 𝓾𝓼𝓮𝓭 𝓕𝓲𝓵𝓮𝓼 " },
    command = "Telescope oldfiles",
  },
  f = {
    description = { "  𝓡𝓮𝓬𝓮𝓷𝓽 𝓟𝓻𝓸𝓳𝓮𝓬𝓽𝓼    " },
    command = "Telescope projects"
  },
  g = {
    description = { " 𝓒𝓱𝓪𝓷𝓰𝓮 𝓒𝓸𝓵𝓸𝓻𝓼𝓬𝓱𝓮𝓶𝓮  "},
    command = "Telescope colorscheme",
  },
  h = {
    description = { "  𝓛𝓲𝓷𝓮𝓼_𝓯𝓻𝓸𝓶_𝓗𝓲𝓼𝓽𝓸𝓻𝔂  " },
    command = ":e ~/.config/nvim/lines_from_history.txt",
  },
  i = {
    description = { "        Ωuï†          " },
    command = ":qa",
  },
}
