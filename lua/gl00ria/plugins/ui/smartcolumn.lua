vim.pack.add { 'https://github.com/m4xshen/smartcolumn.nvim' }
local lazy = require 'gl00ria.config.lazy'
lazy.on_event('BufReadPost', function()
  local ok, smartcolumn = pcall(require, 'smartcolumn')
  if ok then
    smartcolumn.setup {
      colorcolumn = { '80', '120' },
      scope = 'line',
      custom_colorcolumn = {
        python = '88',
      },
      disabled_filetypes = {
        'alpha',
        'dashboard',
        'dap-repl',
        'dapui_scopes',
        'dapui_breakpoints',
        'dapui_stacks',
        'dapui_watches',
        'dap-terminal',
        'dapui_console',
        'help',
        'lazy',
        'markdown',
        'mason',
        'neogitstatus',
        'neo-tree',
        'NvimTree',
        'Outline',
        'lir',
        'oil',
        'packer',
        'spectre_panel',
        'startify',
        'startup',
        'toggleterm',
        'Trouble',
      },
    }
  else
    vim.notify('Failed to load plugin [smartcolumn@smartcolumn.lua]', vim.log.levels.ERROR)
  end
end, 'smartcolumn')
