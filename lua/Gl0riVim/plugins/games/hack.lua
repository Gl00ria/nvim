local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (hack.lua)", vim.log.levels.WARN)
  return
end

local hack_opts = settings.games_plugins.hack

local hack = {}

if hack_opts.enable then
  hack = {
    "letieu/hacker.nvim",
    cmd = hack_opts.cmd,
    keys = hack_opts.keys,
    opts = {
      is_popup = true,
      popup_after = 5,
    },
  }
end

return hack
