-- mapped @which-key
vim.pack.add {
  {
    src = 'https://github.com/nvim-neo-tree/neo-tree.nvim',
    version = vim.version.range '3',
  },
}

local lazy = require 'gl00ria.config.lazy'
lazy.on_ui_enter(function()
  local ok, neo = pcall(require, 'neo-tree')
  if ok then
  neo.setup {
    close_if_last_window = true,
    sources = { 'filesystem', 'buffers', 'git_status' },
    open_files_do_not_replace_types = { 'terminal', 'Trouble', 'trouble', 'qf', 'Outline' },
    filesystem = {
      bind_to_cwd = false,
      follow_current_file = { enabled = true },
      use_libuv_file_watcher = true,
    },
    window = {
      mappings = {
        ['l'] = 'open',
        ['h'] = 'close_node',
        ['<space>'] = 'none',
        ['Y'] = {
          function(state)
            local node = state.tree:get_node()
            local path = node:get_id()
            vim.fn.setreg('+', path, 'c')
          end,
          desc = 'Copy Path to Clipboard',
        },
        ['O'] = {
          function(state) require('lazy.util').open(state.tree:get_node().path, { system = true }) end,
          desc = 'Open with System Application',
        },
        ['P'] = { 'toggle_preview', config = { use_float = false } },
      },
    },
    default_component_configs = {
      indent = {
        with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
        expander_collapsed = '',
        expander_expanded = '',
        expander_highlight = 'NeoTreeExpander',
      },
      git_status = {
        symbols = {
          unstaged = '󰄱',
          staged = '󰱒',
        },
      },
    },
  }
  -- start neo-tree in a dir
  vim.api.nvim_create_autocmd('BufEnter', {
    group = vim.api.nvim_create_augroup('Neotree_start_directory', { clear = true }),
    desc = 'Start Neo-tree with directory',
    once = true,
    callback = function()
      if package.loaded['neo-tree'] then
        return
      else
        local stats = vim.uv.fs_stat(vim.fn.argv(0))
        if stats and stats.type == 'directory' then require 'neo-tree' end
      end
    end,
  })
  else
    vim.notify('Failed to load plugin [NeoTree@neo-tree.lua]', vim.log.levels.ERROR)
  end
end, 'neo_tree')
