local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (nightly.lua)", vim.log.levels.WARN)
  return
end

local nightly_opts = settings.theme_plugins.nightly

local nightly = {}

if nightly_opts.enable then
  nightly = {
    cmd = "",
    "Alexis12119/nightly.nvim",
    opts = {
      color = nightly_opts.style, -- white, blue, black, green or red
      transparent = nightly_opts.transparency,
      styles = {
        comments = { italic = true },
        functions = { italic = true },
        keywords = { italic = true },
        variables = { italic = true },
      },
      -- highlights = {
      --     Normal = { bg = "#000000" }
      -- },
    },
  }
end

return nightly
