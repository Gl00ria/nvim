local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (dashboard.lua)", vim.log.levels.WARN)
  return
end

local dashboard_ops = settings.ui_plugins.dashboard

local alpha = {}

if dashboard_ops.strategy == "alpha" then
  alpha = {
    event = dashboard_ops.event,
    "goolord/alpha-nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("Gl0riVim.plugins.00_config.alpha")
    end,
  }
end

return alpha
