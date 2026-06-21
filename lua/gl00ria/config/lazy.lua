--
-- Lazy-load helper for vim.pack
-- Wraps plugin setup in autocmds so heavy plugins load after startup,
-- on specific events, or on first use.
--
-- Usage:
--   local lazy = require 'gl00ria.config.lazy'
--   lazy.on_event('UIEnter', function()
--     local ok, mod = pcall(require, 'mod')
--     if ok then mod.setup { ... } end
--   end, 'mod_name')
--
local M = {}

--- Run `fn` once after the UI has fully initialised.
--- Use this as the `VeryLazy` equivalent for vim.pack.
--- @param fn fun(): any
--- @param id string    unique id for the augroup (short kebab-case)
function M.on_ui_enter(fn, id)
  vim.api.nvim_create_autocmd('UIEnter', {
    group = vim.api.nvim_create_augroup('lazy_' .. id, { clear = true }),
    once = true,
    callback = fn,
  })
end

--- Run `fn` once when a specific event fires.
--- @param event string|string[]
--- @param fn fun(): any
--- @param id string          unique id for the augroup
--- @param opts? {pattern?: string}
function M.on_event(event, fn, id, opts)
  opts = opts or {}
  vim.api.nvim_create_autocmd(event, {
    group = vim.api.nvim_create_augroup('lazy_' .. id, { clear = true }),
    once = true,
    pattern = opts.pattern,
    callback = fn,
  })
end

return M
