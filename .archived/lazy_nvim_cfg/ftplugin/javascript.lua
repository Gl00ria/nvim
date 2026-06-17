vim.keymap.set("n", "<F5>", function()
  vim.cmd("w")
  vim.cmd("botright split | terminal node " .. vim.fn.expand("%"))
end, { desc = "Run" })
