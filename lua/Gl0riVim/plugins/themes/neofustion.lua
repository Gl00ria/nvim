local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (neofusion.lua)", vim.log.levels.WARN)
  return
end

local neofusion = {}

if settings.theme_plugins.neofusion.enable then
  neofusion = {
    cmd = "",
    "diegoulloao/neofusion.nvim",
  }
end

return neofusion
