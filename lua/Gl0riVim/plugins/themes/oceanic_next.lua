local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (oceanic_next.lua)", vim.log.levels.WARN)
  return
end

local oceanic_next = {}

if settings.theme_plugins.oceanic.enable then
  oceanic_next = {
    cmd = "",
    "mhartington/oceanic-next",
  }
end

return oceanic_next
