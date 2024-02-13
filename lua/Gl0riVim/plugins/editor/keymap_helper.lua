local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (keymap_helper.lua)", vim.log.levels.WARN)
  return
end

local legendary_opts = settings.editor_plugins.legendary

local legendary = {}
if legendary_opts.enable then
  legendary = {
    "mrjones2014/legendary.nvim",
    -- sqlite is only needed if you want to use frecency sorting
    dependencies = { "kkharji/sqlite.lua" },
    cmd = legendary_opts.cmd,
    keys = legendary_opts.keys,
    opts = {
      select_prompt = " legendary.nvim ",
      col_separator_char = "│",
      icons = {
        keymap = "󰌌",
        command = "",
        fn = "󰡱",
        itemgroup = "",
      },
      include_builtin = false,
      -- Include the commands that legendary.nvim creates itself
      -- in the legend by default, set to false to disable
      include_legendary_cmds = true,
      sort = {
        most_recent_first = true,
        -- sort user-defined items before built-in items
        user_items_first = true,
        -- sort the specified item type before other item types,
        -- value must be one of: 'keymap', 'command', 'autocmd', 'group', nil
        item_type_bias = { "keymap", "command", "autocmd", "group" },
        frecency = {
          -- Note: THIS TAKES PRECEDENCE OVER OTHER SORT OPTIONS!
          -- the directory to store the database in
          db_root = string.format("%s/legendary/", vim.fn.stdpath("data")),
          -- the maximum number of timestamps for a single item
          -- to store in the database
          max_timestamps = 10,
        },
      },
      -- Extensions are modules under `legendary.extensions.*`
      extensions = {
        lazy_nvim = {
          auto_register = false,
        },
        which_key = {
          auto_register = true,
          -- controls whether legendary.nvim actually binds they keymaps,
          -- or if you want to let which-key.nvim handle the bindings.
          -- if not passed, true by default
          do_binding = false,
          use_groups = false,
        },
        nvim_tree = false,
        smart_splits = false,
        op_nvim = false,
        diffview = false,
      },
      scratchpad = {
        -- How to open the scratchpad buffer,
        -- 'current' for current window, 'float'
        -- for floating window
        view = "float",
        -- How to show the results of evaluated Lua code.
        -- 'print' for `print(result)`, 'float' for a floating window.
        results_view = "float",
        -- Border style for floating windows related to the scratchpad
        float_border = "rounded",
        -- Whether to restore scratchpad contents from a cache file
        keep_contents = true,
      },
      -- Directory used for caches
      cache_path = string.format("%s/legendary/", vim.fn.stdpath("cache")),
      -- Log level, one of 'trace', 'debug', 'info', 'warn', 'error', 'fatal'
      log_level = "info",
    },
  }
end

local hawtkeys_opts = settings.editor_plugins.hawtkeys
local hawtkeys = {}

if hawtkeys_opts.enable then
  hawtkeys = {
    "tris203/hawtkeys.nvim",
    cmd = hawtkeys_opts.cmd,
    opts = {
      leader = " ", -- the key you want to use as the leader, default is space
      homerow = 2, -- the row you want to use as the homerow, default is 2
      powerFingers = { 2, 3, 6, 7 }, -- the fingers you want to use as the powerfingers, default is {2,3,6,7}
      keyboardLayout = "qwerty", -- the keyboard layout you use, default is qwerty
      customMaps = {
        --- EG local map = vim.api
        --- map.nvim_set_keymap('n', '<leader>1', '<cmd>echo 1')
        {
          ["map.nvim_set_keymap"] = { --name of the expression
            modeIndex = "1", -- the position of the mode setting
            lhsIndex = "2", -- the position of the lhs setting
            rhsIndex = "3", -- the position of the rhs setting
            optsIndex = "4", -- the position of the index table
            method = "dot_index_expression", -- if the function name contains a dot
          },
        },
        --- EG local map2 = vim.api.nvim_set_keymap
        ["map2"] = { --name of the function
          modeIndex = 1, --if you use a custom function with a fixed value, eg normRemap, then this can be a fixed mode eg 'n'
          lhsIndex = 2,
          rhsIndex = 3,
          optsIndex = 4,
          method = "function_call",
        },
        -- If you use whichkey.register with an alias eg wk.register
        ["wk.register"] = {
          method = "which_key",
        },
        -- If you use lazy.nvim's keys property to configure keymaps in your plugins
        ["lazy"] = {
          method = "lazy",
        },
      },
      highlights = { -- these are the highlight used in search mode
        HawtkeysMatchGreat = { fg = "green", bold = true },
        HawtkeysMatchGood = { fg = "green" },
        HawtkeysMatchOk = { fg = "yellow" },
        HawtkeysMatchBad = { fg = "red" },
      },
    },
  }
end

return { legendary, hawtkeys }
