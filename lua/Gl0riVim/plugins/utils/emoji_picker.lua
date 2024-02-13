local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (emojies_picker.lua)", vim.log.levels.WARN)
  return
end

local emoji_opts = settings.utils_plugins.emojies_picker

local nerd_emojies = {}

if emoji_opts.nerd_emojies.enable then
  nerd_emojies = {
    "2kabhishek/nerdy.nvim",
    cmd = emoji_opts.nerd_emojies.cmd,
    keys = emoji_opts.nerd_emojies.keys,
  }
end

return nerd_emojies
