local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (substrata.lua)", vim.log.levels.WARN)
  return
end

local substrata_opts = settings.theme_plugins.substrata

local substrata = {}

if substrata_opts.enable then
  substrata = {
    cmd = "",
    "kvrohit/substrata.nvim",
    config = function()
      vim.g.substrata_transparent = substrata_opts.transparency
      vim.g.substrata_italic_comments = true
      vim.g.ubstrata_italic_keywords = true
      vim.g.substrata_italic_booleans = true
      vim.g.substrata_italic_function = true
      vim.g.substrata_italic_variables = true
    end,
  }
end
return substrata
