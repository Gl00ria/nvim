vim.pack.add { 'https://github.com/leoluz/nvim-dap-go' }
local lazy = require 'gl00ria.config.lazy'
lazy.on_event('BufReadPost', function()
  local ok, dgo = pcall(require, 'dap-go')
  if ok then
    dgo.setup {
      delve = {
        -- On Windows delve must be run attached or it crashes.
        -- See https://github.com/leoluz/nvim-dap-go/blob/main/README.md#configuring
        detached = vim.fn.has 'win32' == 0,
      },
    }
  else
    vim.notify('Failed to load plugin [nvim-dap-go@debug/go.lua]', vim.log.levels.ERROR)
  end
end, 'dap_go')
