return {
  "nvim-pack/nvim-spectre",
  build = false,
  cmd = "Spectre",
  opts = { open_cmd = "noswapfile vnew" },
  keys = {
    { "<leader>sr", false },
    { "<F2>", function() require("spectre").open() end, desc = "Toggle Multi Replace  " },
  },
}
