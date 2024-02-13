local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (rainbow_delimiters.lua)", vim.log.levels.WARN)
  return
end

local rainbow_opts = settings.editor_plugins.rainbow_delimiters

local rainbow_delimiters = {}

if rainbow_opts.enable then
  rainbow_delimiters = {
    event = rainbow_opts.event,
    "hiphish/rainbow-delimiters.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
  }
end

return rainbow_delimiters
