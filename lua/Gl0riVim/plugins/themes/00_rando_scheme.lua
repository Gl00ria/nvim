local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (rando_scheme.lua)", vim.log.levels.WARN)
  return
end

local rando_opts = settings.theme_plugins.rando_scheme
local key = settings.plugins_keymaps

local rando_scheme = {}

if rando_opts.enable then
  rando_scheme = {
    "Gl00ria/rando_scheme",
    dependencies = { "stevearc/dressing.nvim" },
    opts = {
      keymap = rando_opts.keymap,
      random_startup = rando_opts.random_startup,
      startup_schemes = { -- used for startup schemes & in case the user selected 'random_all' from the menu
        -- fav
        "nord",
        "moonlight",
        "nightfox",
        "terafox",
        "onedark",
        "gruvbox",
        "gruvbox-material",
        "gruvbox-baby",
        "tokyonight",
        "tokyonight-moon",
        "onedark_vivid",
        "duskfox",
        "doom-one",
        "neon",
        -- end of fav

        "ariake",
        "monet",
        "cyberdream",
        "min-theme",
        "tokyonight-night",
        "tokyonight-storm",
        "tokyogogh",
        "tokyogogh-night",
        "tokyogogh-storm",
        "catppuccin",
        "catppuccin-frappe",
        "catppuccin-macchiato",
        "catppuccin-mocha",
        "palenightfall",
        "nordfox",
        "nightcity",
      },
      night_schemes = {
        -- fav
        "nord",
        "nightfox",
        "terafox",
        "onedark",
        "gruvbox",
        "gruvbox-material",
        "gruvbox-baby",
        "tokyonight",
        "tokyonight-moon",
        "onedark_vivid",
        "duskfox",
        "doom-one",
        "neon",
        -- end of fav

        "ariake",
        "monet",
        "nightcity",
        "cyberdream",
        "min-theme",
        "tokyonight-night",
        "tokyonight-storm",
        "tokyogogh",
        "tokyogogh-night",
        "tokyogogh-storm",
        "catppuccin",
        "moonlight",
        "catppuccin-frappe",
        "catppuccin-macchiato",
        "catppuccin-mocha",
        "palenightfall",
        "nordfox",
        "carbonfox",
      },
      day_schemes = {
        -- fav
        "nord",
        "onedark",
        "gruvbox-material",
        "onedark_vivid",
        -- end of fav
        "monet",
        "ariake",
        "nightcity",
        "cyberdream",
        "vn-night",
        "tokyonight-day",
        "tokyogogh",
        "catppuccin",
        "catppuccin-latte",
        "moonlight",
        "palenightfall",
        "nordfox",
        "dawnfox",
        "dayfox",
        "onelight",
      },
    },
  }
end
return rando_scheme
