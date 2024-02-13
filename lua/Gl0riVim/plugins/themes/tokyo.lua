local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (tokyo.lua)", vim.log.levels.WARN)
  return
end

local tokyo_opts = settings.theme_plugins.tokyo

local tokyonight = {}
local tokyodark = {}
local tokyogogh = {}

if tokyo_opts.tokyonight.enable then
  tokyonight = {
    cmd = "",
    "folke/tokyonight.nvim",
    opts = {
      style = tokyo_opts.tokyonight.style, -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
      transparent = tokyo_opts.tokyonight.transparency, -- Enable this to disable setting the background color
      light_style = "day", -- The theme is used when the background is set to light
      terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
      styles = {
        comments = { italic = true },
        keywords = { italic = true },
        functions = {},
        variables = {},
        -- Background styles. Can be "dark", "transparent" or "normal"
        sidebars = "dark", -- style for sidebars, see below
        floats = "dark", -- style for floating windows
      },
      sidebars = { "qf", "help" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
      day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
      hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
      dim_inactive = false, -- dims inactive windows
      lualine_bold = false, -- When `true`, section headers in the lualine theme will be bold

      --- You can override specific color groups to use other groups or a hex color
      --- function will be called with a ColorScheme table
      -- on_colors = function(colors) end,

      --- You can override specific highlights to use other groups or a hex color
      --- function will be called with a Highlights and ColorScheme table
      -- on_highlights = function(highlights, colors) end,
    },
  }
end

if tokyo_opts.tokydark.enable then
  tokyodark = {
    cmd = "",
    "tiagovla/tokyodark.nvim",
    config = function()
      if vim.version().minor < 7 then
        vim.notify("Plugin [Tokyodark] requires 0.7 or higher", vim.log.levels.WARN)
        return
      end

      vim.g.tokyodark_transparent_background = tokyo_opts.tokydark.transparency
      vim.g.tokyodark_enable_italic_comment = true
      vim.g.tokyodark_enable_italic = true
      vim.g.tokyodark_color_gamma = "1.0"
    end,
  }
end

if tokyo_opts.tokyohogh.enable then
  tokyogogh = {
    cmd = "",
    "cesaralvarod/tokyogogh.nvim",
    opts = {
      style = tokyo_opts.tokyohogh.style, -- storm | night
    },
  }
end

return { tokyonight, tokyodark, tokyogogh }
