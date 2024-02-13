-- https://github.com/dstein64/vim-startuptime
local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (startuptime.lua)", vim.log.levels.WARN)
  return
end

local startuptime_opts = settings.utils_plugins.startuptime
local startuptime = {}

if startuptime_opts.enable then
  startuptime = {
    "dstein64/vim-startuptime",
    cmd = startuptime_opts.cmd,
  }
end

return startuptime
