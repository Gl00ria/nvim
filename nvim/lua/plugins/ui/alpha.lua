return {
  "goolord/alpha-nvim",
  config = function()
    -- close Lazy and re-open when the dashboard is ready
    if vim.o.filetype == "lazy" then
      vim.cmd.close()
      vim.api.nvim_create_autocmd("User", {
        pattern = "AlphaReady",
        callback = function() require("lazy").show() end,
      })
    end
    -- use a protected call so we don't error out on first use
    local status_ok, alpha = pcall(require, "alpha")
    if not status_ok then
      vim.notify("Plugin [Alpha] failed to load", vim.log.levels.WARN)
      return
    end

    local dashboard = require("alpha.themes.dashboard")

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

    -- 🔔 emoji list (https://unicode.org/emoji/charts/full-emoji-list.html)
    dashboard.section.buttons.val = {
      dashboard.button("1", "📜 Fɪɴᴅ ғɪʟᴇs ", ":Telescope find_files <cr>"),
      dashboard.button("2", "📁 Fɪɴᴅ ғᴏʟᴅᴇʀs", ":Neotree float<cr>"),
      dashboard.button("3", "📝 Nᴇᴡ ғɪʟᴇ ", ":ene! <cr>"),
      dashboard.button("4", "🔍 Fɪɴᴅ ᴛᴇxᴛ", ":Telescope live_grep <cr>"),
      dashboard.button("5", "📉 Rᴇᴄᴇɴᴛʟʏ ᴜsᴇᴅ ғɪʟᴇs", ":Telescope oldfiles <cr>"),
      dashboard.button("6", "📑 Rᴇᴄᴇɴᴛ ᴘʀᴏᴊᴇᴄᴛs", ":Telescope projects <cr>"),
      dashboard.button("7", "🎨 Cʜᴀɴɢᴇ ᴄᴏʟᴏʀsᴄʜᴇᴍᴇ", ":FzfLua colorscheme <cr>"),
      dashboard.button("8", "🧐 Lɪɴᴇs_Fʀᴏᴍ_Hɪsᴛᴏʀʏ", ":e ~/.config/nvim/lines_from_history.txt <cr>"),
      dashboard.button("9", "🔥 Uᴘᴅᴀᴛᴇ", ":Lazy<CR>"),
      dashboard.button(".", "💣 Qᴜɪᴛ", ":qa <cr>"),
    }

    -- Count plugins for Lazymanger
    local lazy_plugins_count = require("lazy").stats().count
    local version = vim.version()
    local nvim_version_info = "v" .. version.major .. "." .. version.minor .. "." .. version.patch
    local datetime = os.date("📆  %d/%m/%Y ⏰  %H:%M:%S") -- 

    dashboard.section.footer.val = "│🔌  "
      .. lazy_plugins_count
      .. "  🧬  "
      .. nvim_version_info
      .. "  "
      .. datetime
      .. "│"
    dashboard.section.footer.opts.hl = "Type"
    dashboard.section.header.opts.hl = "Include"
    dashboard.section.buttons.opts.hl = "Keyword"
    dashboard.opts.opts.noautocmd = true
    alpha.setup(dashboard.opts)

    -- open dashboard after closing lazy
    if vim.o.filetype == "lazy" then
      vim.api.nvim_create_autocmd("WinClosed", {
        pattern = tostring(vim.api.nvim_get_current_win()),
        once = true,
        callback = function()
          vim.schedule(function() vim.api.nvim_exec_autocmds("UIEnter", { group = "dashboard" }) end)
        end,
      })
    end
  end,
}
