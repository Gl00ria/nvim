local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (table_mode.lua)", vim.log.levels.WARN)
  return
end

local table_opts = settings.utils_plugins.table_mode

local table_mode = {}

if table_opts.enable then
  table_mode = {
    "dhruvasagar/vim-table-mode",
    cmd = table_opts.cmd,
    keys = table_opts.keys,
  }
end

return table_mode
