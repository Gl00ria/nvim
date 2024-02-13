local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (vn_night.lua)", vim.log.levels.WARN)
  return
end

local vn_night = {}

if settings.theme_plugins.nv_night.enable then
  vn_night = {
    cmd = "",
    "nxvu699134/vn-night.nvim",
    opts = {},
  }
end

return vn_night
