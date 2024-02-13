local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (nord.lua)", vim.log.levels.WARN)
  return
end

local nord = {}

if settings.theme_plugins.nord.enable then
  nord = {
    cmd = "",
    "shaunsingh/nord.nvim",
  }
end

return nord
