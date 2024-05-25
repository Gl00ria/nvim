local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (fidget.lua)", vim.log.levels.WARN)
  return
end

local fidget = {}
local fid_opts = settings.ui_plugins.fidget

if fid_opts.enable then
  fidget = {
    "j-hui/fidget.nvim",
    event = fid_opts.event,
    opts = {
      notification = {
        window = {
          normal_hl = fid_opts.normal_hl,
          winblend = fid_opts.winblend,
          border = fid_opts.border,
          align = fid_opts.align,
        },
      },
    },
  }
end

return fidget
