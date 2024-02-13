local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (treesitter.autotag.lua)", vim.log.levels.WARN)
  return
end

local ts_autotag_opts = settings.coding_plugins.treesitter.extensions.autotag
local ts_autotag = {}

if ts_autotag_opts.enable then
  ts_autotag = {
    "windwp/nvim-ts-autotag",
    event = ts_autotag_opts.event,
    ft = ts_autotag_opts.ft,
    opts = {
      autotag = { enable = true },
    },
  }
end

return ts_autotag
