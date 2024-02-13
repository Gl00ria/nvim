local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (neon.lua)", vim.log.levels.WARN)
  return
end

local neon = {}

if settings.theme_plugins.neon.enable then
  neon = {
    cmd = "",
    "rafamadriz/neon",
    config = function()
      vim.g.neon_style = settings.theme_plugins.neon.style
      vim.g.neon_transparent = settings.theme_plugins.neon.transparency
      vim.g.neon_italic_keyword = true
      vim.g.neon_italic_function = true
    end,
  }
end

return neon
