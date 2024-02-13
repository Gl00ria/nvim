local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (doom_one.lua)", vim.log.levels.WARN)
  return
end

local doom_opts = settings.theme_plugins.doom
local doom_one = {}

if doom_opts.enable then
  doom_one = {
    cmd = "",
    "NTBBloodbath/doom-one.nvim",
    config = function()
      if vim.version().minor < 6 then
        vim.notify("Plugin [Doom-one] requires 0.6 or higher", vim.log.levels.WARN)
        return
      end

      vim.g.doom_one_cursor_coloring = true

      vim.g.doom_one_terminal_colors = true

      vim.g.doom_one_italic_comments = true

      vim.g.doom_one_enable_treesitter = true

      vim.g.doom_one_diagnostics_text_color = true

      vim.g.doom_one_transparent_background = doom_opts.transparency

      -- Pumblend transparency
      vim.g.doom_one_pumblend_enable = true
      vim.g.doom_one_pumblend_transparency = 20

      -- Plugins integration
      vim.g.doom_one_plugin_neorg = true
      vim.g.doom_one_plugin_barbar = true
      vim.g.doom_one_plugin_telescope = true

      -- vim.g.doom_one_plugin_neogit = false
      vim.g.doom_one_plugin_nvim_tree = true
      vim.g.doom_one_plugin_dashboard = true

      -- vim.g.doom_one_plugin_startify = false
      -- vim.g.doom_one_plugin_whichkey = false
      vim.g.doom_one_plugin_indent_blankline = true
      -- vim.g.doom_one_plugin_vim_illuminate = false
      vim.g.doom_one_plugin_lspsaga = true
    end,
  }
end

return doom_one
