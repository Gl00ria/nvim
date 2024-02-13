local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (secureitree.lua)", vim.log.levels.WARN)
  return
end

local secureitree = {}

if settings.coding_plugins.secureitree.enable then
  secureitree = {
    "GeekMasher/securitree.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("securitree").setup({})
    end,
  }
end

return secureitree
