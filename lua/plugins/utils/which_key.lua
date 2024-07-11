return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    plugins = { spelling = true },
    defaults = {
      mode = { "n", "v" },
      ["g"] = { name = "+Goto  " },
      ["gs"] = { name = "+Surround 󰗅 " },
      ["z"] = { name = "+Fold  " },
      ["]"] = { name = "+Next  " },
      ["["] = { name = "+Prev  " },
      ["<leader><tab>"] = { name = "+Tabs  " },
      ["<leader>b"] = { name = "+Buffer  " },
      ["<leader>c"] = { name = "+Coding 󰘦 " },
      ["<leader>F"] = { name = "+Fun 󰐔 " },
      ["<leader>f"] = { name = "+File/Find  " },
      ["<leader>g"] = { name = "+Git  " },
      ["<leader>gh"] = { name = "+Hunks  ", ["_"] = "which_key_ignore" },
      ["<leader>P"] = {
        name = "+Plugin Manager 󱐥",
        d = "Dashboard 󰨇 ",
        e = "Extras  ",
        L = "Change Log  ",
      },
      ["<leader>q"] = { name = "+Quit/Session 󰿅 " },
      ["<leader>r"] = {
        { name = "+Replace/Rando Scheme" },
        r = "Rando Scheme  ",
        w = { "Replace word v/n mode", mode = { "x", "n" } },
        u = { "Replace word under cursor v/n mode", mode = { "v", "n" } },
      },
      ["<leader>s"] = { name = "+Search  " },
      ["<leader>u"] = { name = "+Utils 󱑟 " },
      ["<leader>w"] = {
        name = "+Window  ",
        d = "Delete Window  ",
        j = "Split Window Below 󰤻 ",
        l = "Split Window Right 󰤼 ",
        o = "Goto Other Window  ",
      },
      ["<leader>x"] = { name = "+Diagnostics/Quickfix 󰁨 " },
    },
  },
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)
    wk.register(opts.defaults)
  end,
}
