local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (monet.lua)", vim.log.levels.WARN)
  return
end

local monet_opts = settings.theme_plugins.monet
local monet = {}

if monet_opts.enable then
  monet = {
    "fynnfluegge/monet.nvim",
    name = "monet",
  }
end

return monet
