local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (buffremove.lua)", vim.log.levels.WARN)
  return
end

local mini_buf_remove = {}

if settings.editor_plugins.buff_remove.enable then
  mini_buf_remove = {
    "echasnovski/mini.bufremove",
    keys = settings.editor_plugins.buff_remove.keys,
  }
end

return mini_buf_remove
