vim.keymap.set("n", "<F5>", function()
  vim.cmd("w")
  vim.cmd("!dotnet build")
  vim.cmd("botright split | terminal dotnet run " .. vim.fn.expand("%"))
end, { desc = "Run" })
