local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (mellow.lua)", vim.log.levels.WARN)
  return
end

local mellow_opts = settings.theme_plugins.mellow

local mellow = {}

if mellow_opts.enable then
  mellow = {
    cmd = "",
    "kvrohit/mellow.nvim",
    config = function()
      vim.g.mellow_italic_functions = true
      vim.g.mellow_bold_functions = true
      vim.g.mellow_transparent = mellow_opts.transparency
    end,
  }
end

return mellow
