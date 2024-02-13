local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (citruszest.lua)", vim.log.levels.WARN)
  return
end

local cit_opts = settings.theme_plugins.citruszest

local citruszest = {}

if cit_opts.enable then
  citruszest = {
    cmd = "",
    "zootedb0t/citruszest.nvim",
    opts = {
      option = {
        transparent = cit_opts.transparency, -- Enable/Disable transparency
        italic = true,
        bold = true,
      },
      -- Override default highlight style in this table
      -- E.g If you want to override `Constant` highlight style
      style = {
        -- This will change Constant foreground color and make it bold.
        Constant = { fg = "#FFFFFF", bold = true },
      },
    },
  }
end

return citruszest
