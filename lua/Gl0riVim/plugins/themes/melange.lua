local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (melange.lua)", vim.log.levels.WARN)
  return
end

local melange = {}

if settings.theme_plugins.melange.enable then
  melange = {
    cmd = "",
    "savq/melange",
    opts = {},
  }
end
return melange
