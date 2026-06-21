--
-- keymaps handled via (Trouble or Telescope)
-- choose only one and uncommment the 'which-key' section below
--
vim.pack.add {
  'https://github.com/folke/todo-comments.nvim',
  'https://github.com/folke/trouble.nvim',
  -- 'https://github.com/nvim-telescope/telescope.nvim',
}

local lazy = require 'gl00ria.config.lazy'
lazy.on_event('BufReadPost', function()
  local ok, todo_comments = pcall(require, 'todo-comments')
  if ok then
  todo_comments.setup {
    {
      signs = true, -- show icons in the signs column
      sign_priority = 8, -- sign priority
      keywords = {
        FIX = {
          alt = { 'FIXME', 'FIXES', 'BUG', 'BUGS', 'FIXIT', 'ISSUE', 'ISSUES' }, -- a set of other keywords that all map to this FIX keywords
          -- signs = false, -- configure signs for some keywords individually
        },
        TODO = { alt = { 'TIP', 'TIPS' } },
        WARN = { alt = { 'WARNING', 'CAREFULL', 'WATCHOUT' } },
        PERF = { alt = { 'PERFORMANCE', 'OPTIMIZE', 'INHANCE' } },
        HINT = { alt = { 'HINTS' } },
        NOTE = { alt = { 'NOTES', 'INFO', 'INFOS' } },
        gui_style = {
          fg = 'NONE', -- The gui style to use for the fg highlight group.
          bg = 'BOLD', -- The gui style to use for the bg highlight group.
        },
        highlight = {
          multiline = true, -- enable multine todo comments
          multiline_context = 3, -- extra lines that will be re-evaluated when changing a line
          before = '', -- "fg" or "bg" or empty
          keyword = 'wide', -- "fg", "bg", "wide" or empty. (wide is the same as bg, but will also highlight surrounding characters)
          after = 'fg', -- "fg" or "bg" or empty
          pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlightng (vim regex)
          comments_only = true, -- uses treesitter to match keywords in comments only
          max_line_len = 400, -- ignore lines longer than this
          exclude = {}, -- list of file types to exclude highlighting
        },
        search = {
          command = 'rg',
          args = { '--color=always', '--no-heading', '--with-filename', '--line-number', '--column' },
          -- regex that will be used to match keywords.
          -- don't replace the (KEYWORDS) placeholder
          pattern = [[\b(KEYWORDS):]], -- ripgrep regex
        },
      },
    },
  }

  -- Via trouble
  -- Trouble todo toggle filter = {tag = {TODO,FIX,FIXME}}
  require('which-key').add {
    {
      {
        '<leader>//',
        -- "<cmd>TodoTelescope keywords=FIX,FIXME,FIXES,FIXIT,BUG,BUGS,ISSUE,ISSUES,TODO,TIP,TIPS,HACK,WARN,WARNING,PERF,PERFORMANCE,OPTIMIZE,HINT,HINTS,NOTE,NOTES,INFO,INFOS<cr>",
        -- '<cmd>Trouble todo toggle filter = {tag={}<cr>',
        '<cmd>Trouble todo toggle filter = {tag = {FIX,FIXME,FIXES,FIXIT,BUG,BUGS,ISSUE,ISSUES,TODO,TIP,TIPS,HACK,WARN,WARNING,PERF,PERFORMANCE,OPTIMIZE,HINT,HINTS,NOTE,NOTES,INFO,INFOS}}<cr>',
        desc = 'Find All Todo Comments',
        icon = 'All 󱨰 ',
      },
      { '<leader>/b', '<cmd>Trouble todo toggle filter = {tag = {BUG, BUGS}}<cr>', desc = 'Find Bugs', icon = 'BUG 󰃤 ' },
      { '<leader>/f', '<cmd>Trouble todo toggle filter = {tag = {FIX,FIXME,FIXES,FIXIT}}<cr>', desc = 'Find Fixes', icon = 'FIX 󰁨 ' },
      { '<leader>/H', '<cmd>Trouble todo toggle filter = {tag = {HINT,HINTS}}<cr>', desc = 'Find Hints', icon = 'HINT 󱠃 ' },
      { '<leader>/h', '<cmd>Trouble todo toggle filter = {tag = {HACK}}<cr>', desc = 'Find Hacks', icon = 'HACK 󰈸 ' },
      { '<leader>/I', '<cmd>Trouble todo toggle filter = {tag = {INFO,INFOS}}<cr>', desc = 'Find Infos', icon = 'INFO  ' },
      { '<leader>/i', '<cmd>Trouble todo toggle filter = {tag = {ISSUE,ISSUES}}<cr>', desc = 'Find Issues', icon = 'ISSUE  ' },
      { '<leader>/n', '<cmd>Trouble todo toggle filter = {tag = {NOTE, NOTES}}<cr>', desc = 'Find Notes', icon = 'NOTE 󰠮 ' },
      { '<leader>/p', '<cmd>Trouble todo toggle filter = {tag = {PERF,PERFORMANCE,OPTIMIZE}}<cr>', desc = 'Find Perf', icon = 'PERFORMANCE 󰥔 ' },
      { '<leader>/t', '<cmd>Trouble todo toggle filter = {tag = {TODO}}<cr>', desc = 'Find ToDoS', icon = 'TODO  ' },
      { '<leader>/T', '<cmd>Trouble todo toggle filter = {tag = {TIP,TIPS}}<cr>', desc = 'Find Tips', icon = 'TIP 󰴓 ' },
      { '<leader>/w', '<cmd>Trouble todo toggle filter = {tag = {WARN,WARNING}}<cr>', desc = 'Find Warns', icon = 'WARN  ' },
      { ']t', function() require('todo-comments').jump_next() end, desc = 'Next TODO  ' },
      { '[t', function() require('todo-comments').jump_prev() end, desc = 'Prev TODO  ' },
      -- stylua: ignore end
    },
  }

-- via Telescope
-- require('which-key').add {
--   {
--     {
--       '<leader>//',
--       -- "<cmd>TodoTelescope keywords=FIX,FIXME,FIXES,FIXIT,BUG,BUGS,ISSUE,ISSUES,TODO,TIP,TIPS,HACK,WARN,WARNING,PERF,PERFORMANCE,OPTIMIZE,HINT,HINTS,NOTE,NOTES,INFO,INFOS<cr>",
--       '<cmd>TodoTelescope keywords=FIX,FIXME,FIXES,FIXIT,BUG,BUGS,ISSUE,ISSUES,TODO,TIP,TIPS,HACK,WARN,WARNING,PERF,PERFORMANCE,OPTIMIZE,HINT,HINTS,NOTE,NOTES,INFO,INFOS<cr>',
--       desc = 'All 󱨰 ',
--     },
--     { '<leader>/b', '<cmd>TodoTelescope keywords=BUG,BUGS<cr>', desc = 'BUG 󰃤 ' },
--     { '<leader>/f', '<cmd>TodoTelescope keywords=FIX,FIXME,FIXES,FIXIT<cr>', desc = 'FIX 󰁨 ' },
--     { '<leader>/H', '<cmd>TodoTelescope keywords=HINT,HINTS<cr>', desc = 'HINT 󱠃 ' },
--     { '<leader>/h', '<cmd>TodoTelescope keywords=HACK<cr>', desc = 'HACK 󰈸 ' },
--     { '<leader>/I', '<cmd>TodoTelescope keywords=INFO,INFOS<cr>', desc = 'INFO  ' },
--     { '<leader>/i', '<cmd>TodoTelescope keywords=ISSUE,ISSUES<cr>', desc = 'ISSUE  ' },
--     { '<leader>/n', '<cmd>TodoTelescope keywords=NOTE,NOTES<cr>', desc = 'NOTE 󰠮 ' },
--     { '<leader>/p', '<cmd>TodoTelescope keywords=PERF,PERFORMANCE,OPTIMIZE<cr>', desc = 'PERFORMANCE 󰥔 ' },
--     { '<leader>/t', '<cmd>TodoTelescope keywords=TODO<cr>', desc = 'TODO  ' },
--     { '<leader>/T', '<cmd>TodoTelescope keywords=TIP,TIPS<cr>', desc = 'TIP 󰴓 ' },
--     { '<leader>/w', '<cmd>TodoTelescope keywords=WARN,WARNING<cr>', desc = 'WARN  ' },
--     { ']t', function() require('todo-comments').jump_next() end, desc = 'Next TODO  ' },
--     { '[t', function() require('todo-comments').jump_prev() end, desc = 'Prev TODO  ' },
--     -- stylua: ignore end
--   },
-- }
  else
    vim.notify('Failed to load plugin [todo-comments@todo-comments.lua]', vim.log.levels.ERROR)
  end
end, 'todo_comments')
