local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (barbecue.lua)", vim.log.levels.WARN)
  return
end

local bar_opts = settings.coding_plugins.barbecue

local barbecue = {}
if bar_opts.enable then
  barbecue = {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    version = "*",
    event = bar_opts.event,
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons", -- optional dependency
    },
    opts = {},
  }
end

return barbecue
