local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (dial.lua)", vim.log.levels.WARN)
  return
end

local undotree_opts = settings.utils_plugins.undo_tree

local undotree = {}

if undotree_opts.enable then
  undotree = {
    "mbbill/undotree",
    event = undotree_opts.event,
    cmd = undotree_opts.cmd,
    keys = undotree_opts.keys,
    config = function()
      vim.cmd([[
            if has("persistent_undo")

            let target_path = expand('~/.custom_db/nvim/plugins/undotree/')

            " create the directory and any parent directories
            " if the location does not exist.
            if !isdirectory(target_path)
            call mkdir(target_path, "p", 0700)
            endif

            let &undodir=target_path
            set undofile
            endif
            ]])
    end,
  }
end

return undotree
