local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (vim_be_good.lua)", vim.log.levels.WARN)
  return
end

local vim_be_good = {}

if settings.games_plugins.vim_be_good.enable then
  vim_be_good = {
    "ThePrimeagen/vim-be-good",
    cmd = settings.games_plugins.vim_be_good.cmd,
    keys = settings.games_plugins.vim_be_good.keys,
  }
end

return vim_be_good
