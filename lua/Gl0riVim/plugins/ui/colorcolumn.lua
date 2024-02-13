local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (colorcolumn.lua)", vim.log.levels.WARN)
  return
end

local smart_column = {}
local virt_column = {}

local column_opts = settings.ui_plugins.colorcolumn

if column_opts.smart_column.enable then
  smart_column = {
    "m4xshen/smartcolumn.nvim",
    event = column_opts.smart_column.event,
    opts = {
      colorcolumn = column_opts.smart_column.colorcolumn,
      scope = column_opts.smart_column.scope,
      custom_colorcolumn = column_opts.smart_column.custom_colorcolumn,
      disabled_filetypes = {
        "alpha",
        "dashboard",
        "dap-repl",
        "dapui_scopes",
        "dapui_breakpoints",
        "dapui_stacks",
        "dapui_watches",
        "dap-terminal",
        "dapui_console",
        "help",
        "lazy",
        "markdown",
        "mason",
        "neogitstatus",
        "neo-tree",
        "NvimTree",
        "Outline",
        "lir",
        "oil",
        "packer",
        "spectre_panel",
        "startify",
        "startup",
        "toggleterm",
        "Trouble",
      },
    },
  }
end

return { smart_column, virt_column }
