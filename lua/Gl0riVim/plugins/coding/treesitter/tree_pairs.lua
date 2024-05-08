local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (tree_pairs.lua)", vim.log.levels.WARN)
  return
end

local pair_opts = settings.coding_plugins.treesitter.tree_pair
local pair = {}

if pair_opts.enable then
  pair = {
    "yorickpeterse/nvim-tree-pairs",
    configs = function()
      local pari_status, tree_pair = pcall(require, "tree-pairs")
      if not pari_status then
        vim.notify("Plugin [pair] failed to load within (treesitter.lua)", vim.log.levels.WARN)
        return
      end
      tree_pair.setup()
    end,
  }
end

return pair
