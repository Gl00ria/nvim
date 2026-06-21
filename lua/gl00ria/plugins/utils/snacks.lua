vim.pack.add { 'https://github.com/folke/snacks.nvim' }

local lazy = require 'gl00ria.config.lazy'
lazy.on_event('BufReadPost', function()
  local ok, Snacks = pcall(require, 'snacks')
  if ok then
  Snacks.setup {
    dashboard = { enabled = false },

    gitbrowse = { enabled = false }, -- no need
    -- profiler = { enabled = false },
    image = { eanbled = false },
    terminal = { enabled = false },
    scratch = { enabled = false },

    --
    -- Auto-show LSP references and quickly navigate between them
    -- keymap = true
    --
    words = { enabled = true },
    scroll = { enabled = true },
    dim = { enabled = true },
    toggle = { enabled = true },
    input = { enabled = true },
    bigfile = { enabled = true },
    quickfile = { enabled = true }, --  quickly load a file before loading any plugin

    gh = { enabled = true }, -- GitHub issues and pull requests, keymap = true

    lazygit = { -- keymap = true
      enabled = true,
      -- https://github.com/folke/snacks.nvim/issues/46
      -- Change default settings to open edits in the current tab, not a new one
      config = {
        os = {
          edit = 'if test -z "$NVIM"; nvim -- {{filename}}; else; nvim --server "$NVIM" --remote-send "q"; nvim --server "$NVIM" --remote {{filename}}; end',
          editAtLine = 'if test -z "$NVIM"; nvim +{{line}} -- {{filename}}; else; nvim --server "$NVIM" --remote-send "q"; nvim --server "$NVIM" --remote {{filename}}; nvim --server "$NVIM" --remote-send ":{{line}}<CR>"; end',
          editAtLineAndWait = 'nvim +{{line}} {{filename}}',
          openDirInEditor = 'if test -z "$NVIM"; nvim -- {{dir}}; else; nvim --server "$NVIM" --remote-send "q"; nvim --server "$NVIM" --remote {{dir}}; end',
        },
      },
    },

    zen = {
      toggles = {
        dim = false,
      },
      show = {
        statusline = true,
        tabline = true,
      },
    },

    indent = {
      animate = {
        enabled = true,
        only_scope = false,
      },
    },

    scope = {
      -- The textobjects ignore cursor column;
      -- ignore it for the scope guide too so we know what we'll select
      cursor = false,
      -- filter = function()
      --   -- It works weirdly in markdown
      --   return vim.bo.filetype ~= 'markdown'
      -- end,
      keys = {
        textobject = {
          ii = {
            linewise = true,
          },
          ai = {
            linewise = true,
          },
        },
      },
    },

    statuscolumn = {
      enabled = true,
      folds = {
        open = true,
      },
    },

    explorer = {
      enabled = false, -- mofo still here
      replace_netrw = false,
    },
    picker = {
      ui_select = true,
      -- sources = {
      --   explorer = {
      --     hidden = true,
      --     auto_close = false,
      --     -- layout = { layout = { position = 'right' } },
      --   },
      --   grep = {
      --     hidden = true,
      --   },
      -- },
      -- layout = {
      --   -- More room for file path
      --   preset = 'vertical',
      -- },
      formatters = {
        file = {
          truncate = 69,
        },
        selected = {
          show_always = true,
          unselected = false,
        },
      },
      win = {
        preview = {
          wo = {
            number = vim.o.number,
            relativenumber = vim.o.relativenumber,
            signcolumn = vim.o.signcolumn,
            wrap = true,
          },
        },
      },
    },

    notifier = { -- Used by noice
      timeout = 3000, -- default timeout in ms
      width = { min = 40, max = 0.4 },
      height = { min = 1, max = 0.6 },
      -- editor margin to keep free. tabline and statusline are taken into account automatically
      margin = { top = 0, right = 1, bottom = 0 },
      padding = true, -- add 1 cell of left/right padding to the notification window
      gap = 0, -- gap between notifications
      sort = { 'level', 'added' }, -- sort by level and time
      -- minimum log level to display. TRACE is the lowest
      -- all notifications are stored in history
      level = vim.log.levels.TRACE,
      icons = {
        error = ' ',
        warn = ' ',
        info = ' ',
        debug = ' ',
        trace = ' ',
      },
    },
  }

  local wk_ok, wk = pcall(require, 'which-key')
  if wk_ok then
    wk.add {
      { '<F1>', function() Snacks.picker.keymaps() end, desc = 'Search Keymaps', icon = ' ' },
      -- <F2> --> taken by @search-replace.lua
      { '<F3>', function() Snacks.picker.undo() end, desc = 'Undo History', icon = ' ' },
      -- <F4> --> taken by @trouble.lua for diagnostics
      -- <F5> --> taken by @trouble.lua for diagnostics

      { '<leader>N', function() Snacks.picker.notifications() end, desc = 'Notifications', icon = '󱜺' },
      { '<leader>:', function() Snacks.picker.command_history() end, desc = 'Command History', icon = '' },

      -- find
      { '<leader>ff', function() Snacks.picker.files() end, desc = 'Find Files', icon = '󰈞' },
      -- { '<leader>ff', function() Snacks.picker.smart() end, desc = 'Files', icon = '󰈞' }, # problem it pulls files other the CWD too
      { '<leader>fb', function() Snacks.picker.buffers() end, desc = 'Buffers', icon = '󰮗' },
      { '<leader>fw', function() Snacks.picker.grep() end, desc = 'Word', icon = '󱎒' },
      { '<leader>fw', mode = { 'x' }, function() Snacks.picker.grep_word() end, desc = 'Find Word (N  & X)', icon = '󱎒' },
      { '<leader>fp', function() Snacks.picker.projects() end, desc = 'Projects', icon = '' },
      { '<leader>fr', function() Snacks.picker.recent() end, desc = 'Recent', icon = '󰛔' },

      -- buffers: delete
      { 'Q', function() Snacks.bufdelete.delete() end, desc = 'Delete Current Buffer', icon = '󰠙' },
      { '<leader>bda', function() Snacks.bufdelete.all() end, desc = 'Delete all buffers', icon = '󰆳 ' },
      { '<leader>bdo', function() Snacks.bufdelete.other() end, desc = 'Delete other buffers', icon = '󱂥 ' },

      -- Toggle
      { '<leader>ts', function() Snacks.toggle.option('spell', { name = 'Spelling' }):map '<leader>ts' end, desc = 'Spelling', icon = ' ' },
      { '<leader>tw', function() Snacks.toggle.option('wrap', { name = 'Wrap' }):map '<leader>tw' end, desc = 'Wrap', icon = '󰖶 ' },
      { '<leader>td', function() Snacks.toggle.diagnostics():map '<leader>td' end, desc = 'Toggle Diagnostics', icon = ' ' },
      { '<leader>tl', function() Snacks.toggle.line_number():map '<leader>tl' end, desc = 'Toggle LineNumber', icon = '󰉻 ' },
      { '<leader>tt', function() Snacks.toggle.treesitter():map '<leader>tt' end, desc = 'Toggle Treesitter', icon = ' ' },
      { '<leader>th', function() Snacks.toggle.inlay_hints():map '<leader>th' end, desc = 'Toggle InlayHints', icon = ' ' },
      { '<leader>ti', function() Snacks.toggle.indent():map '<leader>ti' end, desc = 'Toggle Indent', icon = '' },
      { '<leader>td', function() Snacks.toggle.dim():map '<leader>td' end, desc = 'Toggle Dim', icon = '🔅' },
      {
        '<leader>tr',
        function() Snacks.toggle.option('relativenumber', { name = 'Toggle Relativenumber' }):map '<leader>tr' end,
        desc = 'Toggle Relativenumber',
        icon = ' ',
      },
      {
        '<leader>tc',
        function() Snacks.toggle.option('conceallevel', { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map '<leader>tc' end,
        desc = 'Toggle ConcealLevel',
        icon = '󰘓 ',
      },
      {
        '<leader>tb',
        function() Snacks.toggle.option('background', { off = 'light', on = 'dark', name = 'Dark Background' }):map '<leader>tb' end,
        desc = 'Toggle Background',
        icon = '󰁭 ',
      },

      -- git
      { '<leader>gg', function() Snacks.lazygit() end, desc = 'Lazygit', icon = ' ' },
      { '<leader>gf', function() Snacks.picker.git_files() end, desc = 'Find Git Files', icon = '' },
      { '<leader>gF', function() Snacks.picker.git_log_file() end, desc = 'Git Log File', icon = ' ' },
      { '<leader>gb', function() Snacks.picker.git_branches() end, desc = 'Git Branches', icon = '' },
      { '<leader>gl', function() Snacks.picker.git_log() end, desc = 'Git Log', icon = ' ' },
      { '<leader>gL', function() Snacks.picker.git_log_line() end, desc = 'Git Log Line', icon = ' ' },
      { '<leader>gs', function() Snacks.picker.git_status() end, desc = 'Git Status', icon = ' ' },
      { '<leader>gd', function() Snacks.picker.git_diff() end, desc = 'Git Diff (Hunks)', icon = '󰄶 ' },
      -- WARN: gS mapped to 'mini-splitjoin' in mode 'x'
      -- { '<leader>gS', function() Snacks.picker.git_stash() end, desc = 'Git Stash' },

      -- GitHub
      { '<leader>gi', function() Snacks.picker.gh_issue() end, desc = 'GitHub Issues (open)' },
      { '<leader>gI', function() Snacks.picker.gh_issue { state = 'all' } end, desc = 'GitHub Issues (all)' },
      { '<leader>gp', function() Snacks.picker.gh_pr() end, desc = 'GitHub Pull Requests (open)' },
      { '<leader>gP', function() Snacks.picker.gh_pr { state = 'all' } end, desc = 'GitHub Pull Requests (all)' },
      { '<leader>gB', function() Snacks.gitbrowse() end, desc = 'Git Browse', mode = { 'n', 'v' } },

      --
      -- search
      --
      { '<leader>sa', function() Snacks.picker.autocmds() end, desc = 'Autocmds', icon = '󰁩 ' },
      { '<leader>sb', function() Snacks.picker.lines() end, desc = 'Buffer Lines', icon = ' ' },
      { '<leader>sc', function() Snacks.picker.colorschemes() end, desc = 'Colorschemes', icon = '󱛐 ' },
      { '<leader>sC', function() Snacks.picker.command_history() end, desc = 'Command History', icon = ' ' },
      { '<leader>s:', function() Snacks.picker.commands() end, desc = 'Commands', icon = ' ' },
      -- { '<leader>sd', function() Snacks.picker.diagnostics() end, desc = 'Diagnostics' },
      -- { '<leader>sD', function() Snacks.picker.diagnostics_buffer() end, desc = 'Buffer Diagnostics' },
      { '<leader>sr"', function() Snacks.picker.registers() end, desc = 'Registers', icon = ' ' },
      { '<leader>sh', function() Snacks.picker.search_history() end, desc = 'Search History', icon = ' ' },
      { '<leader>s?', function() Snacks.picker.help() end, desc = 'Help Pages', icon = '󰞋 ' },
      { '<leader>sH', function() Snacks.picker.highlights() end, desc = 'Highlights', icon = ' ' },
      { '<leader>si', function() Snacks.picker.icons() end, desc = 'Icons', icon = ' ' },
      { '<leader>sj', function() Snacks.picker.jumps() end, desc = 'Jumps', icon = '󱋿 ' },
      { '<leader>sl', function() Snacks.picker.loclist() end, desc = 'Location List', icon = ' ' },
      { '<leader>sm', function() Snacks.picker.marks() end, desc = 'Marks', icon = ' ' },
      { '<leader>sM', function() Snacks.picker.man() end, desc = 'Man Pages', icon = '󰋦 ' },
      -- { '<leader>sp', function() Snacks.picker.lazy() end, desc = 'Search for Plugin Spec' },
      { '<leader>sq', function() Snacks.picker.qflist() end, desc = 'Quickfix List', icon = ' ' },
      -- { '<leader>sR', function() Snacks.picker.resume() end, desc = 'Resume' },

      -- Other
      -- Entry to toggle --> example <leader>tz
      { '<leader>z', function() Snacks.zen() end, desc = 'Toggle Zen Mode' },
      { '<leader>n', function() Snacks.notifier.show_history() end, desc = 'Notification History' },
      -- LSP
      --  handled via 'trouble.nvim'
      -- { 'gd', function() Snacks.picker.lsp_definitions() end, desc = 'Goto Definition' },
      -- { 'gD', function() Snacks.picker.lsp_declarations() end, desc = 'Goto Declaration' },
      -- { 'gr', function() Snacks.picker.lsp_references() end, nowait = true, desc = 'References' }, -- handled @trouble
      -- { 'gI', function() Snacks.picker.lsp_implementations() end, desc = 'Goto Implementation' },
      -- { 'gy', function() Snacks.picker.lsp_type_definitions() end, desc = 'Goto T[y]pe Definition' },
      -- { 'gai', function() Snacks.picker.lsp_incoming_calls() end, desc = 'C[a]lls Incoming' },
      -- { 'gao', function() Snacks.picker.lsp_outgoing_calls() end, desc = 'C[a]lls Outgoing' },
      -- { '<leader>ss', function() Snacks.picker.lsp_symbols() end, desc = 'LSP Symbols' },
      -- { '<leader>sS', function() Snacks.picker.lsp_workspace_symbols() end, desc = 'LSP Workspace Symbols' },

      -- OTHER --> dont need'em
      -- { '<leader>cR', function() Snacks.rename.rename_file() end, desc = 'Rename File' },
      -- { '<leader>un', function() Snacks.notifier.hide() end, desc = 'Dismiss All Notifications' },
      -- { '<c-/>', function() Snacks.terminal() end, desc = 'Toggle Terminal' },
      -- { '<c-_>', function() Snacks.terminal() end, desc = 'which_key_ignore' },
      -- { ']]', function() Snacks.words.jump(vim.v.count1) end, desc = 'Next Reference', mode = { 'n', 't' } },
    }
  else
    vim.notify('Failed to load plugin [Which-key@snacks.lua]', vim.log.levels.ERROR)
  end
else
  vim.notify('Failed to load plugin [snacks@snacks.lua]', vim.log.levels.ERROR)
end
end, 'snacks')
