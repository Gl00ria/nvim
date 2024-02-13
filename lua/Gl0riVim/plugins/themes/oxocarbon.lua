local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (oxocarbon.lua)", vim.log.levels.WARN)
  return
end

local oxocarbon = {}

if settings.theme_plugins.oxocarbon.enable then
  oxocarbon = {
    cmd = "",
    "nyoom-engineering/oxocarbon.nvim",
  }
end

return oxocarbon
