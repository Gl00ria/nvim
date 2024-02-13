local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (Gl0riVim.init.lua)", vim.log.levels.WARN)
  return
end

if not settings.make_me_nacked then
  require("Gl0riVim.config.options")
  require("Gl0riVim.config.autocmds")
  require("Gl0riVim.config.lazy")
  require("Gl0riVim.config.keymaps")
  require("Gl0riVim.config.neovide")
end
