return {
  "folke/snacks.nvim",
  keys = {
    { "Q", function() Snacks.bufdelete() end, desc = "Remove Current Buffer  " },
  },
  opts = {
    dashboard = { enabled = false },
  },
}
