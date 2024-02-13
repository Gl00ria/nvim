local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (darkplus.lua)", vim.log.levels.WARN)
  return
end

local darkplus = {}

if settings.theme_plugins.darkplus.enable then
  darkplus = {
    cmd = "",
    "martinsione/darkplus.nvim",
    opts = {},
  }
end

return darkplus
