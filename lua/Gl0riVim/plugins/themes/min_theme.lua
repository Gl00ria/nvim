local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (min_theme.lua)", vim.log.levels.WARN)
  return
end

local min_opts = settings.theme_plugins.min

local min_theme = {}

if min_opts.enable then
  min_theme = {
    cmd = "",
    "datsfilipe/min-theme.nvim",
    opts = {
      theme = min_opts.style, -- String: 'dark' or 'light', determines the colorscheme used (obs: if your config sets vim.o.background, this will do nothing)
      transparent = min_opts.transparency, -- Boolean: Sets the background to transparent
      italics = {
        comments = true, -- Boolean: Italicizes comments
        keywords = true, -- Boolean: Italicizes keywords
        functions = true, -- Boolean: Italicizes functions
        strings = true, -- Boolean: Italicizes strings
        variables = true, -- Boolean: Italicizes variables
      },
      overrides = {}, -- A dictionary of group names, can be a function returning a dictionary or a table.
    },
  }
end
return min_theme
