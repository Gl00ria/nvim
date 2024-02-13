local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (everblush.lua)", vim.log.levels.WARN)
  return
end

local ever_opts = settings.theme_plugins.everblush

local everblush = {}

if ever_opts.enable then
  everblush = {
    cmd = "",
    "Everblush/nvim",
    name = "everblush",
    opts = {
      -- Default options
      override = {},
      transparent_background = ever_opts.transparency,
      nvim_tree = {
        contrast = false,
      },
    },
  }
end

return everblush
