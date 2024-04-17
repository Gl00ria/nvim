local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (yanky.lua)", vim.log.levels.WARN)
  return
end

local yanky_opts = settings.utils_plugins.yanky

local yanky = {}

if yanky_opts.enable then
  yanky = {
    "gbprod/yanky.nvim",
    dependencies = { "kkharji/sqlite.lua" },
    keys = yanky_opts.keys,
    opts = {
      ring = {
        history_length = yanky_opts.history_length,
        storage = "sqlite", -- "sqlite", "shada"
        storage_path = yanky_opts.storage_path,
      },
      system_clipboard = {
        sync_with_ring = yanky_opts.sync_with_ring,
      },
      highlight = {
        on_put = yanky_opts.highlight.on_put,
        on_yank = yanky_opts.highlight.on_yank,
        timer = yanky_opts.highlight.timer, -- 500
      },
      preserve_cursor_position = {
        enabled = yanky_opts.preserve_cursor_position,
      },
      textobj = {
        enabled = yanky_opts.textobj,
      },
    },
  }
end

return yanky
