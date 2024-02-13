local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (flirt.lua)", vim.log.levels.WARN)
  return
end

local flirt = {}

if settings.ui_plugins.flirt.enable then
  flirt = {
    "tamton-aquib/flirt.nvim",
    opts = {
      override_open = true, -- experimental
      close_command = "Q",
      default_move_mappings = true, -- <C-arrows> to move floats
      default_resize_mappings = true, -- <A-arrows> to resize floats
      default_mouse_mappings = true, -- Drag floats with mouse
      exclude_fts = { "notify", "cmp_menu" },
      custom_filter = function(buffer, win_config)
        return vim.bo[buffer].filetype == "cmp_menu" -- avoids animation
      end,
    },
  }
end

return flirt
