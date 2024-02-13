local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (treesj.lua)", vim.log.levels.WARN)
  return
end

local split_opts = settings.coding_plugins.split_join

local treesj = {}

if split_opts.enable then
  treesj = {
    "Wansmer/treesj",
    cmd = split_opts.cmd,
    keys = split_opts.keys,
    opts = {
      use_default_keymaps = false,
    },
  }
end

return treesj
