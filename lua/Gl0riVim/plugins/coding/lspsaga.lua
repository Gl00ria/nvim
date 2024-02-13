local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (lspsaga.lua)", vim.log.levels.WARN)
  return
end

local icons_status, icons = pcall(require, "icons")
if not icons_status then
  vim.notify("[icons] failed to load within (lspsaga.lua)", vim.log.levels.WARN)
  return
end

local lspsaga_opts = settings.coding_plugins.lspsaga

local lspsaga = {}

if lspsaga_opts.enable then
  lspsaga = {
    "glepnir/lspsaga.nvim",
    event = lspsaga_opts.event,
    cmd = lspsaga_opts.cmd,
    keys = lspsaga_opts.keys,
    opts = {
      ui = {
        theme = "round",
        title = true,
        border = "shadow", -- Available: single | double | rounded | solid | shadow
        winblend = 10,
        expand = "",
        collapse = "",
        preview = " ",
        code_action = icons.Lightbulb,
        diagnostic = icons.Bug,
        incoming = icons.Incoming_calls,
        outgoing = icons.Outgoing_calls,
        colors = {
          -- Normal background color for floating window
          normal_bg = "#000000",
          -- Title background color
          title_bg = "#afd700",
          red = "#e95678",
          magenta = "#b33076",
          orange = "#FF8700",
          yellow = "#f7bb3b",
          green = "#afd700",
          cyan = "#36d0e0",
          blue = "#61afef",
          purple = "#CBA6F7",
          white = "#d1d4cf",
          black = "#1c1c19",
        },
      },
      preview = {
        lines_above = 0,
        lines_below = 10,
      },
      scroll_preview = {
        scroll_down = "<C-u>",
        scroll_up = "<C-d>",
      },
      request_timeout = 2000,
      -- lsp_finder definition, reference and implementation
      finder = {
        --percentage
        max_height = 0.5,
        keys = {
          jump_to = "p",
          edit = { "o", "<CR>" },
          vsplit = "<leader>l",
          split = "<leader>j",
          tabe = "t",
          tabnew = "r",
          quit = { "q", "<ESC>" },
          close_in_preview = "<ESC>",
        },
      },
      definition = {
        edit = "<C-c>o",
        vsplit = "<leader>l",
        split = "<leader>j",
        tabe = "<C-c>t",
        quit = "q",
        close = "<Esc>",
      },
      code_action = {
        num_shortcut = true,
        show_server_name = true,
        extend_gitsigns = true,
        keys = {
          -- string | table type
          quit = "q",
          exec = "<CR>",
        },
      },
      lightbulb = {
        enable = false,
        enable_in_insert = true,
        sign = true,
        sign_priority = 40,
        -- virtual_text = true,
      },
      diagnostic = {
        on_insert = false,
        on_insert_follow = false,
        insert_winblend = 0,
        show_code_action = true,
        show_source = true,
        jump_num_shortcut = true,
        --1 is max
        max_width = 0.7,
        custom_fix = nil,
        custom_msg = nil,
        text_hl_follow = false,
        border_follow = true,
        keys = {
          exec_action = "o",
          quit = "q",
          go_action = "g",
        },
      },
      rename = {
        quit = "<C-k>",
        exec = "<CR>",
      },
      outline = {
        win_position = "right",
        win_width = 30,
        auto_preview = true,
        detail = true,
        auto_close = true,
        layout = "normal", -- Available: normal | float
        keys = {
          jump = "o",
          quit = "q",
        },
      },
      callhierarchy = {
        show_detail = false,
        keys = {
          edit = "e",
          vsplit = "<leader>l",
          split = "<leader>j",
          tabe = "t",
          jump = "o",
          quit = "q",
          expand_collapse = "u",
        },
      },
      symbol_in_winbar = {
        enable = true,
        separator = " ﰲ ",
        hide_keyword = true,
        show_file = true,
        folder_level = 2,
        respect_root = false,
        color_mode = true,
      },
      beacon = {
        enable = false,
        frequency = 7,
      },
    },
  }
end

return lspsaga
