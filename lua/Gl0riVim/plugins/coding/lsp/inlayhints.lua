local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (inlayhints.lua)", vim.log.levels.WARN)
  return
end

local inlayhints = {}
if settings.coding_plugins.inlayhints.enable then
  inlayhints = {
    lazy = true,
    "lvimuser/lsp-inlayhints.nvim",
    event = settings.coding_plugins.inlayhints.event,
  }
end

return inlayhints
