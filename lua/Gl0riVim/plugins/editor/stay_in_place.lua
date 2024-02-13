local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (in_place.lua)", vim.log.levels.WARN)
  return
end

local stay_opts = settings.editor_plugins.stay_in_place

local in_place = {}

if stay_opts.enable then
  in_place = {
    event = stay_opts.event,
    "gbprod/stay-in-place.nvim",
    opts = {},
  }
end

return in_place
