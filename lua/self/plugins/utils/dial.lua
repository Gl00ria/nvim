return {
  "monaqa/dial.nvim",
  cmd = {
    "DialIncrement",
    "DialDecrement",
  },
  keys = {
    { "<leader>K", "<cmd>DialIncrement<cr>", desc = "Dial Increment  " },
    { "<leader>J", "<cmd>DialDecrement<cr>", desc = "Dial Decrement  " },
  },
}
