return {
  "NStefan002/screenkey.nvim",
  version = "*",
  cmd = "Screenkey",
  keys = {
    { "<leader>Es", "<cmd>Screenkey<cr>", desc = "Enable Screenkey 󰧹 " },
  },
  opts = {
    win_opts = {
      width = 40,
      height = 3,
      border = "rounded",
    },
    compress_after = 4,
    clear_after = 4,
    group_mappings = false,
  },
}
