local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (onedark.lua)", vim.log.levels.WARN)
  return
end

local onedark_opts = settings.theme_plugins.ondedark

local onedark = {}
local onedark_pro = {}

if onedark_opts.ondedark_main.enable then
  onedark = {
    cmd = "",
    "navarasu/onedark.nvim",
    opts = {
      -- Main options --
      style = onedark_opts.ondedark_main.style,
      transparent = onedark_opts.ondedark_main.transparency, -- Show/hide background
      term_colors = true, -- Change terminal color as per the selected theme style
      ending_tildes = false, -- Show the end-of-buffer tildes. By default they are hidden
      -- toggle theme style ---
      -- toggle_style_key = '', -- Default keybinding to toggle
      toggle_style_list = { "dark", "darker", "cool", "deep", "warm", "warmer", "light" }, -- List of styles to toggle between

      -- Change code style ---
      -- Options are italic, bold, underline, none
      -- You can configure multiple style with comma separated, For e.g., keywords = 'italic,bold'
      code_style = {
        comments = "italic",
        keywords = "bold",
        functions = "bold",
        strings = "none",
        variables = "italic",
      },

      -- Custom Highlights --
      colors = {}, -- Override default colors
      highlights = {}, -- Override highlight groups

      -- Plugins Config --
      diagnostics = {
        darker = true, -- darker colors for diagnostic
        undercurl = true, -- use undercurl instead of underline for diagnostics
        background = true, -- use background color for virtual text
      },
    },
  }
end

if onedark_opts.ondedark_pro.enable then
  onedark_pro = {
    cmd = "",
    "olimorris/onedarkpro.nvim",
    opts = {},
  }
end

return { onedark, onedark_pro }
