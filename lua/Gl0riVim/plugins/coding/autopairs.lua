local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (auopairs.lua)", vim.log.levels.WARN)
  return
end

local autopairs_opts = settings.coding_plugins.autopairs

local autopairs = {}
local smart_tab = {}

if autopairs_opts.enable then
  autopairs = {
    "altermo/ultimate-autopair.nvim",
    event = autopairs_opts.event,
    opts = {
      tabout = {
        enable = false,
        -- map = "<c-t>", --string or table
        -- cmap = "<c-t>", --string or table
        multi = false,
        hopout = true,
        do_nothing_if_fail = true,
      },
    },
  }
end

local smart_tab_opts = settings.coding_plugins.smart_tab

if settings.coding_plugins.smart_tab.enable then
  smart_tab = {
    "boltlessengineer/smart-tab.nvim",
    event = smart_tab_opts.event,
    opts = {
      -- default options:
      -- list of tree-sitter node types to filter
      skips = { "string_content" },
      -- default mapping, set `false` if you don't want automatic mapping
      mapping = smart_tab_opts.key,
    },
  }
end

return { autopairs, smart_tab }
