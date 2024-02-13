local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (palenightfall.lua)", vim.log.levels.WARN)
  return
end

local palenightfall = {}

if settings.theme_plugins.palenightfall.enable then
  palenightfall = {
    cmd = "",
    "JoosepAlviste/palenightfall.nvim",
    opts = {},
  }
end

return palenightfall
