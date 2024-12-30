return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts_extend = { "spec" },
  opts = {
    defaults = {},
    spec = {
      -- Available colors: azure, blue, cyan, green, grey, orange, purple, red, yellow
      {
        mode = { "n", "v" },
        { "<leader><tab>", group = "Tabs" },
        { "<leader>a", group = "Add", icon = { icon = " ", color = "red" } },
        { "<leader>c", group = "Code" },
        { "<leader>F", group = "Fun", icon = { icon = "󰐔 ", color = "azure" } },
        { "<leader>f", group = "File/Find" },
        { "<leader>g", group = "Git" },
        { "<leader>gh", group = "Hunks" },
        { "<leader>l", group = "Live/List", icon = { icon = "󰝖 ", color = "blue" } },
        { "<leader>m", group = "Mark", icon = { icon = "", color = "green" } },
        { "<leader>P", group = "Plugin Manager", icon = { icon = " ", color = "yellow" } },
        { "<leader>q", group = "Quit/Session" },
        { "<leader>r", group = "Replace", icon = { icon = " ", color = "red" } },
        { "<leader>s", group = "Search" },
        { "<leader>t", group = "Toggle", icon = { icon = " ", color = "blue" } },
        { "<leader>u", group = "Utils", icon = { icon = "󱑟 ", color = "cyan" } },
        { "<leader>x", group = "diagnostics/quickfix", icon = { icon = "󱖫 ", color = "green" } },
        { "[", group = "prev" },
        { "]", group = "next" },
        { "g", group = "goto" },
        { "gs", group = "surround" },
        { "z", group = "fold" },
        {
          "<leader>b",
          group = "buffer",
          expand = function() return require("which-key.extras").expand.buf() end,
        },
        {
          "<leader>w",
          group = "windows",
          proxy = "<c-w>",
          expand = function() return require("which-key.extras").expand.win() end,
        },
        -- better descriptions
        { "gx", desc = "Open with system app" },
      },
    },
  },
  keys = {
    {
      "<leader>?",
      function() require("which-key").show { global = false } end,
      desc = "Buffer Keymaps (which-key)",
    },
    { "<c-w><space>", false },
  },
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)
    if not vim.tbl_isempty(opts.defaults) then
      LazyVim.warn("which-key: opts.defaults is deprecated. Please use opts.spec instead.")
      wk.register(opts.defaults)
    end
  end,
}
