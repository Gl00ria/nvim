local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (calvera.lua)", vim.log.levels.WARN)
  return
end

local clavera = {}

if settings.theme_plugins.calvera.enable then
  clavera = {
    cmd = "",
    "yashguptaz/calvera-dark.nvim",
    config = function()
      vim.g.calvera_italic_keywords = false
      vim.g.calvera_italic_comments = true
      vim.g.calvera_italic_functions = true
      vim.g.calvera_italic_variables = true

      vim.g.calvera_disable_background = true

      vim.g.calvera_borders = false
      vim.g.calvera_contrast = true
      vim.g.calvera_lighter_contrast = false
      vim.g.calvera_hide_eob = true
      vim.g.calvera_custom_colors = { contrast = "#0f111a" }

      require("calvera").set()
    end,
  }
end

return clavera
