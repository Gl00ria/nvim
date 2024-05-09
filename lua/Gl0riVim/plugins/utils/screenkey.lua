local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (screenkey.lua)", vim.log.levels.WARN)
  return
end

local sk_opts = settings.utils_plugins.screenkey
local screenkey = {}

if sk_opts.enable then
  screenkey = {
    "NStefan002/screenkey.nvim",
    version = "*",
    cmd = sk_opts.cmd,
    keys = sk_opts.keys,
    opts = {
      win_opts = {
        width = sk_opts.width,
        height = sk_opts.height,
        border = sk_opts.border,
      },
      compress_after = sk_opts.compress_after,
      clear_after = sk_opts.clear_after,
      group_mappings = sk_opts.group_mappings,
    },
  }
end
return screenkey
