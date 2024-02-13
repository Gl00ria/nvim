local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (cyberdream.lua)", vim.log.levels.WARN)
  return
end

local cyber_opts = settings.theme_plugins.cyberdream

local cyber = {}

if cyber_opts.enable then
  cyber = {
    "scottmckendry/cyberdream.nvim",
    cmd = "",
    opts = {
      -- Recommended - see "Configuring" below for more config options
      transparent = cyber_opts.transparency,
      italic_comments = true,
      hide_fillchars = true,
      borderless_telescope = true,
    },
  }
end

return cyber
