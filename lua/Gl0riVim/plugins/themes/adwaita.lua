local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (adwaita.lua)", vim.log.levels.WARN)
  return
end

local adwaita_opts = settings.theme_plugins.adwaita

local adwaita = {}

if adwaita_opts.enable then
  adwaita = {
    cmd = "",
    "Mofiqul/adwaita.nvim",
    config = function()
      vim.g.adwaita_darker = adwaita_opts.dark_mode -- for darker version
      vim.g.adwaita_transparent = adwaita_opts.transparency -- makes the background transparent
      vim.g.adwaita_disable_cursorline = true -- to disable cursorline
    end,
  }
end

return adwaita
