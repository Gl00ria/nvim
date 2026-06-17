vim.keymap.set("n", "<F5>", function()
  vim.cmd("w")
  vim.cmd("botright split | terminal python " .. vim.fn.expand("%"))
end, { desc = "Run" })
