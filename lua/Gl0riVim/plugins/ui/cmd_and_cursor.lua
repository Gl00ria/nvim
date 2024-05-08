local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (cmd_and_cursor.lua)", vim.log.levels.WARN)
  return
end

local cmd_and_cursor_opts = settings.ui_plugins.cmd_and_cursor
local cmd_and_cursor = {}

if cmd_and_cursor_opts.enable then
  cmd_and_cursor = {
    "moyiz/command-and-cursor.nvim",
    event = cmd_and_cursor_opts.event,
    opts = {},
  }
end

return cmd_and_cursor
