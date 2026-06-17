--
-- this will load everything in 'gl00ria' recursively
-- i use the other miss below to debug
--
-- local function require_all(dir, prefix)
--   for name, type in vim.fs.dir(dir) do
--     local path = vim.fs.joinpath(dir, name)
--
--     if type == 'directory' then
--       require_all(path, prefix .. '.' .. name)
--     elseif type == 'file' and name ~= 'init.lua' and name:match '%.lua$' then
--       require(prefix .. '.' .. name:gsub('%.lua$', ''))
--     end
--   end
-- end
--
-- require_all(vim.fs.joinpath(vim.fn.stdpath 'config', 'lua', 'gl00ria', 'plugins'), 'gl00ria.plugins')

--
-- load everything under 'gl00ria.plugins.1st_load' dir
--
local load_root = vim.fs.joinpath(vim.fn.stdpath 'config', 'lua', 'gl00ria', 'plugins', '1st_load')
local function load_dir(dir, prefix)
  for name, type in vim.fs.dir(dir) do
    local path = vim.fs.joinpath(dir, name)

    if type == 'directory' then
      load_dir(path, prefix .. '.' .. name)
    elseif type == 'file' and name:match '%.lua$' and name ~= 'init.lua' then
      require(prefix .. '.' .. name:gsub('%.lua$', ''))
    end
  end
end
load_dir(load_root, 'gl00ria.plugins.1st_load')

----
---- load everything under 'gl00ria.plugins.ai' dir
----
local ai_root = vim.fs.joinpath(vim.fn.stdpath 'config', 'lua', 'gl00ria', 'plugins', 'ai')
local function ai_dir(dir, prefix)
  for name, type in vim.fs.dir(dir) do
    local path = vim.fs.joinpath(dir, name)

    if type == 'directory' then
      ai_dir(path, prefix .. '.' .. name)
    elseif type == 'file' and name:match '%.lua$' and name ~= 'init.lua' then
      require(prefix .. '.' .. name:gsub('%.lua$', ''))
    end
  end
end
ai_dir(ai_root, 'gl00ria.plugins.ai')

--
--
-- load everything under 'gl00ria.plugins.coding' dir
--
local coding_root = vim.fs.joinpath(vim.fn.stdpath 'config', 'lua', 'gl00ria', 'plugins', 'coding')
local function coding_dir(dir, prefix)
  for name, type in vim.fs.dir(dir) do
    local path = vim.fs.joinpath(dir, name)

    if type == 'directory' then
      coding_dir(path, prefix .. '.' .. name)
    elseif type == 'file' and name:match '%.lua$' and name ~= 'init.lua' then
      require(prefix .. '.' .. name:gsub('%.lua$', ''))
    end
  end
end
coding_dir(coding_root, 'gl00ria.plugins.coding')

--
-- load everything under 'gl00ria.editor' dir
--
local editor_root = vim.fs.joinpath(vim.fn.stdpath 'config', 'lua', 'gl00ria', 'plugins', 'editor')
local function editor_dir(dir, prefix)
  for name, type in vim.fs.dir(dir) do
    local path = vim.fs.joinpath(dir, name)

    if type == 'directory' then
      editor_dir(path, prefix .. '.' .. name)
    elseif type == 'file' and name:match '%.lua$' and name ~= 'init.lua' then
      require(prefix .. '.' .. name:gsub('%.lua$', ''))
    end
  end
end
editor_dir(editor_root, 'gl00ria.plugins.editor')

--
-- load everything under 'gl00ria.plugins.ui' dir
--
local ui_root = vim.fs.joinpath(vim.fn.stdpath 'config', 'lua', 'gl00ria', 'plugins', 'ui')

local function ui_dir(dir, prefix)
  for name, type in vim.fs.dir(dir) do
    local path = vim.fs.joinpath(dir, name)

    if type == 'directory' then
      ui_dir(path, prefix .. '.' .. name)
    elseif type == 'file' and name:match '%.lua$' and name ~= 'init.lua' then
      require(prefix .. '.' .. name:gsub('%.lua$', ''))
    end
  end
end

ui_dir(ui_root, 'gl00ria.plugins.ui')

--
-- load everything under 'gl00ria.plugins.utils' dir
--
local utils_root = vim.fs.joinpath(vim.fn.stdpath 'config', 'lua', 'gl00ria', 'plugins', 'utils')
local function utils_dir(dir, prefix)
  for name, type in vim.fs.dir(dir) do
    local path = vim.fs.joinpath(dir, name)

    if type == 'directory' then
      utils_dir(path, prefix .. '.' .. name)
    elseif type == 'file' and name:match '%.lua$' and name ~= 'init.lua' then
      require(prefix .. '.' .. name:gsub('%.lua$', ''))
    end
  end
end
utils_dir(utils_root, 'gl00ria.plugins.utils')
