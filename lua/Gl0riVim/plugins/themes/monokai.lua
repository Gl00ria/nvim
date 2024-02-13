local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (monokai_nightasty.lua)", vim.log.levels.WARN)
  return
end

local monokai_opts = settings.theme_plugins.monokai

local monokai_nightasty = {}
local monokai_pro = {}

if monokai_opts.monokai_nightasty.enable then
  monokai_nightasty = {
    cmd = "",
    "polirritmico/monokai-nightasty.nvim",
    opts = {
      dark_style_background = "dark", -- default, dark, transparent, #color
      light_style_background = "default", -- default, dark, transparent, #color
      terminal_colors = true, -- Set the colors used when opening a `:terminal`
      color_headers = true, -- Enable header colors for each header level (h1, h2, etc.)
      hl_styles = {
        -- Style to be applied to different syntax groups. See `:help nvim_set_hl`
        comments = { italic = true },
        keywords = { italic = false },
        functions = {},
        variables = {},
        -- Background styles for sidebars (panels) and floating windows:
        floats = "default", -- default, dark, transparent
        sidebars = "default", -- default, dark, transparent
      },
      sidebars = { "qf", "help" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`

      hide_inactive_statusline = false, -- Hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
      dim_inactive = false, -- dims inactive windows
      lualine_bold = true, -- Lualine headers will be bold or regular.
      lualine_style = "dark", -- "dark", "light" or "default" (Follows dark/light style)

      --- You can override specific color/highlights. Current values in `extras/palettes`

      on_colors = function(colors)
        colors.border = colors.grey
        colors.comment = "#2d7e79"
      end,

      on_highlights = function(highlights, colors)
        highlights.TelescopeNormal = { fg = colors.magenta, bg = colors.charcoal }
        highlights.WinSeparator = { fg = colors.grey }
      end,
    },
  }
end

if monokai_opts.monokai_pro.enable then
  monokai_pro = {
    cmd = "",
    "loctvl842/monokai-pro.nvim",
    opts = {
      transparent_background = monokai_opts.monokai_pro.transparency,
      terminal_colors = true,
      devicons = true, -- highlight the icons of `nvim-web-devicons`
      italic_comments = true,
      filter = monokai_opts.monokai_pro.filter, -- classic | octagon | pro | machine | ristretto | spectrum
      -- Enable this will disable filter option
      day_night = {
        enable = false, -- turn off by default
        day_filter = "spectrum", -- classic | octagon | pro | machine | ristretto | spectrum
        night_filter = "spectrum", -- classic | octagon | pro | machine | ristretto | spectrum
      },
      inc_search = "background", -- underline | background
      background_clear = {
        -- "float_win",
        "toggleterm",
        "telescope",
        "which-key",
        "renamer",
      }, -- "float_win", "toggleterm", "telescope", "which-key", "renamer", "neo-tree"
      plugins = {
        bufferline = {
          underline_selected = false,
          underline_visible = false,
        },
        indent_blankline = {
          context_highlight = "default", -- default | pro
          context_start_underline = false,
        },
      },
    },
  }
end

return { monokai_nightasty, monokai_pro }
