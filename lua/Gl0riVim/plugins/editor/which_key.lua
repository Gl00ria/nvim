return {
  event = "VeryLazy",
  "folke/which-key.nvim",
  opts = {
    plugins = {
      marks = true,
      registers = true,
      spelling = {
        enabled = true,
        suggestions = 20,
      },
      presets = {
        operators = false,
        motions = false,
        text_objects = false,
        windows = false,
        nav = false,
        z = false,
        g = false,
      },
    },
    -- operators = { gc = "Comments" },
    key_labels = {
      ["<space>"] = "󱁐",
      ["telescope"] = " ",
      ["Telescope"] = " ",
      ["operator"] = "",
    },
    motions = {
      count = true,
    },
    icons = {
      breadcrumb = "»",
      separator = "➜ ",
      group = " ", -- "+" | "" | "<>",
    },
    popup_mappings = {
      scroll_down = "<c-d>",
      scroll_up = "<c-u>",
    },
    window = {
      border = "none", -- Available: none | single | double | shadow
      margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
      padding = { 1, 2, 1, 2 }, -- extra window padding etop, right, bottom, left
      position = "bottom", -- Available: bottom | top
      winblend = 0,
    },
    layout = {
      height = { min = 5, max = 40 }, -- min and max height of the columns
      width = { min = 20, max = 80 }, -- min and max width of the columns
      spacing = 3,
      align = "center", -- Available: left | right | center
    },
    ignore_missing = false,
    hidden = {
      "<silent>",
      "<cmd>",
      "<Cmd>",
      "<CR>",
      "call",
      "lua",
      "^:",
      "^ ",
      "require",
      "escope",
      "erator",
      '"',
    }, --
    show_help = true,
    show_keys = true,
    triggers = "auto",
    triggers_nowait = {
      -- marks
      "`",
      "'",
      "g`",
      "g'",

      -- registers
      '"',
      "<c-r>",

      -- spelling
      "z=",
    },
    triggers_blacklist = {
      i = { "j", "k" },
      v = { "j", "k" },
    },
    disable = {
      buftypes = {},
      filetypes = {},
    },
  },
  config = function()
    require("Gl0riVim.plugins.00_config.rg_whichkey")
  end,
}
