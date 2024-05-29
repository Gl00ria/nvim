local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (northern.lua)", vim.log.levels.WARN)
  return
end

local northern = {}
local northern_opts = settings.theme_plugins.northern

if northern_opts.enable then
  northern = { "fcancelinha/northern.nvim" }
end

return northern
