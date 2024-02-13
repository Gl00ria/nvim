local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (lspkind.lua)", vim.log.levels.WARN)
  return
end

local kind_opts = settings.ui_plugins.lspkind

local lspkind = {}

if kind_opts.enable then
  lspkind = {
    event = kind_opts.event,
    "onsails/lspkind-nvim",
  }
end

return lspkind
