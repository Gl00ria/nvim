local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (cellular_automation.lua)", vim.log.levels.WARN)
  return
end

local cellular_opts = settings.games_plugins.cellular_automation

local cellular_automation = {}

if cellular_opts.enable then
  cellular_automation = {
    "eandrju/cellular-automaton.nvim",
    dependencies = "nvim-treesitter/nvim-treesitter",
    cmd = cellular_opts.cmd,
    keys = cellular_opts.keys,
  }
end

return cellular_automation
