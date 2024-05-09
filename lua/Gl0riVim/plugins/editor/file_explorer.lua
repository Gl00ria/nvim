local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (file_exporer.lua)", vim.log.levels.WARN)
  return
end

local file_explorer_opts = settings.editor_plugins.file_explorer

local treetype = {}

if file_explorer_opts.strategy == "nvim-tree" then
  treetype = {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "b0o/nvim-tree-preview.lua",
    },
    cmd = file_explorer_opts.nvim_tree_opts.cmd,
    keys = file_explorer_opts.nvim_tree_opts.keys,
    config = function()
      require("Gl0riVim.plugins.00_config.nvim-tree")
    end,
  }
elseif file_explorer_opts.strategy == "neo-tree" then
  vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
  treetype = {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    cmd = file_explorer_opts.neo_tree_opts.cmd,
    keys = file_explorer_opts.neo_tree_opts.keys,
    config = function()
      require("Gl0riVim.plugins.00_config.neo-tree")
    end,
  }
elseif file_explorer_opts.strategy == "ranger" then
  treetype = {
    "kevinhwang91/rnvimr",
    keys = file_explorer_opts.ranger_opts.keys,
    init = function()
      vim.g.rnvimr_enable_picker = 1
      vim.g.rnvimr_border_attr = { fg = 3, bg = -1 }
      vim.g.rnvimr_shadow_winblend = 90
    end,
  }
end

return treetype
