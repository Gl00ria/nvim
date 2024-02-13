local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (beacon.lua)", vim.log.levels.WARN)
  return
end

local beacon_opts = settings.ui_plugins.beacon

local beacon = {}

if beacon_opts.enable then
  beacon = {
    "rainbowhxch/beacon.nvim",
    event = beacon_opts.event,
    opts = {
      enable = true,
      size = 60,
      fade = true,
      minimal_jump = 10,
      show_jumps = true,
      focus_gained = false,
      shrink = true,
      timeout = 1000,
      ignore_buffers = {},
      ignore_filetypes = {},
    },
    config = function()
      vim.cmd("hi Beacon guibg=red ctermbg=15")
    end,
  }
end

return beacon
