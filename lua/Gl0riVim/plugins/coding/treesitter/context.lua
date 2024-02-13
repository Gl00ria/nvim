local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (treesitter/context.lua)", vim.log.levels.WARN)
  return
end

local ts_context_opts = settings.coding_plugins.treesitter.extensions.context

local treesitter_context = {}

if ts_context_opts.enable then
  treesitter_context = {
    "nvim-treesitter/nvim-treesitter-context",
    cmd = { "TSContextEnable", "TSContextDisable", "TSContextToggle" },
    event = ts_context_opts.event,
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {
      enable = true,
      max_lines = 0,
      min_window_height = 0,
      line_numbers = true,
      multiline_threshold = 20,
      trim_scope = "outer",
      mode = "cursor",
      separator = nil,
      zindex = 20,
      on_attach = nil,
    },
  }
end

return treesitter_context
