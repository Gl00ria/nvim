--
-- Recursively load all .lua plugin files from a plugins subdirectory.
--
local function scan_plugins_dir(dir, prefix)
  for name, type in vim.fs.dir(dir) do
    local path = vim.fs.joinpath(dir, name)

    if type == 'directory' then
      scan_plugins_dir(path, prefix .. '.' .. name)
    elseif type == 'file' and name:match '%.lua$' and name ~= 'init.lua' then
      require(prefix .. '.' .. name:gsub('%.lua$', ''))
    end
  end
end

local root = vim.fs.joinpath(vim.fn.stdpath 'config', 'lua', 'gl00ria', 'plugins')

scan_plugins_dir(vim.fs.joinpath(root, '1st_load'), 'gl00ria.plugins.1st_load')
scan_plugins_dir(vim.fs.joinpath(root, 'ai'), 'gl00ria.plugins.ai')
scan_plugins_dir(vim.fs.joinpath(root, 'coding'), 'gl00ria.plugins.coding')
scan_plugins_dir(vim.fs.joinpath(root, 'editor'), 'gl00ria.plugins.editor')
scan_plugins_dir(vim.fs.joinpath(root, 'ui'), 'gl00ria.plugins.ui')
scan_plugins_dir(vim.fs.joinpath(root, 'utils'), 'gl00ria.plugins.utils')
