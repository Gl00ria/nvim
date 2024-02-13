local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (nightfox.lua)", vim.log.levels.WARN)
  return
end

local nf_opts = settings.theme_plugins.nightfox

local nightfox = {}

if nf_opts.enable then
  nightfox = {
    cmd = "",
    "EdenEast/nightfox.nvim",
    opts = {
      options = {
        -- Compiled file's destination location
        compile_path = vim.fn.stdpath("cache") .. "/nightfox",
        compile_file_suffix = "_compiled", -- Compiled file suffix
        transparent = nf_opts.transparency,
        terminal_colors = true, -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
        dim_inactive = false, -- Non focused panes set to alternative background
        styles = { -- Style to be applied to different syntax groups
          comments = "NONE", -- Value is any valid attr-list value `:help attr-list`
          functions = "NONE",
          keywords = "NONE",
          numbers = "NONE",
          strings = "NONE",
          types = "NONE",
          variables = "NONE",
        },
        inverse = { -- Inverse highlight for different types
          match_paren = false,
          visual = false,
          search = false,
        },
      },
    },
  }
end

return nightfox
