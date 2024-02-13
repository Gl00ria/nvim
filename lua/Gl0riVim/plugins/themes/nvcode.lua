local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (nvcode.lua)", vim.log.levels.WARN)
  return
end

local nvcode = {}

if settings.theme_plugins.nvcode.enable then
  nvcode = {
    cmd = "",
    "christianchiarulli/nvcode-color-schemes.vim",
  }
end

return nvcode
