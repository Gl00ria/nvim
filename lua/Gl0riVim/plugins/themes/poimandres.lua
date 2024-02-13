local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (poimandres.lua)", vim.log.levels.WARN)
  return
end

local poimandres = {}

if settings.theme_plugins.poimandres.enable then
  poimandres = {
    cmd = "",
    "olivercederborg/poimandres.nvim",
    opts = {
      bold_vert_split = false, -- use bold vertical separators
      dim_nc_background = false, -- dim 'non-current' window backgrounds
      disable_background = false, -- disable background
      disable_float_background = false, -- disable background for floats
      disable_italics = false, -- disable italics
    },
  }
end

return poimandres
