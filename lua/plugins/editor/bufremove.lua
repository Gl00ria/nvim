return {
  "echasnovski/mini.bufremove",
  version = "*",
  keys = {
    { "Q", function() require("mini.bufremove").delete(0, false) end, desc = "Close Current Buffer" },
  },
}
