local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (oh_lucy.lua)", vim.log.levels.WARN)
  return
end

local oh_lucy = {}

if settings.theme_plugins.oh_lucy.enable then
  oh_lucy = {
    cmd = "",
    "Yazeed1s/oh-lucy.nvim",
    config = function()
      if vim.version().minor < 8 then
        vim.notify("Theme [Oh Lucy] requires 0.8 or higher", vim.log.levels.WARN)
        return
      end
      vim.g.oh_lucy_italic_comments = true
    end,
  }
end
return oh_lucy
