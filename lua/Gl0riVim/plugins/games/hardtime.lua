local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (hardtime.lua)", vim.log.levels.WARN)
  return
end

local hard_opts = settings.games_plugins.hardtime

local hard_time = {}

if hard_opts.enable then
  hard_time = {
    "m4xshen/hardtime.nvim",
    event = hard_opts.event,
    keys = hard_opts.keys,
    opts = {
      max_count = hard_opts.max_count,
      max_time = 1000,
      hint = true,
      notification = true,
      disable_mouse = false,
      allow_different_key = true,
      disabled_filetypes = { "qf", "NvimTree", "lazy", "mason", "neo-tree", "noice", "NeogitStatus", "oil", "netrw" },
      disabled_keys = {},
    },
  }
end

return hard_time
