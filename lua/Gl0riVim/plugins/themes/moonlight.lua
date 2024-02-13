local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (moonlight.lua)", vim.log.levels.WARN)
  return
end

local moonlight = {}

if settings.theme_plugins.moonlight.enable then
  moonlight = {
    cmd = "",
    "shaunsingh/moonlight.nvim",
  }
end
return moonlight
