local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (ariake.lua)", vim.log.levels.WARN)
  return
end

local ariake_opts = settings.theme_plugins.ariake
local ariake = {}

if ariake_opts.enable then
  ariake = {
    "jim-at-jibba/ariake.nvim",
    cmd = "",
  }
end

return ariake
