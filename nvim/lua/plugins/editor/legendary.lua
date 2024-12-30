return {
  "mrjones2014/legendary.nvim",
  -- sqlite is only needed if you want to use frecency sorting
  dependencies = { "kkharji/sqlite.lua" },
  cmd = "Legendary",
  keys = {
    { "<leader><leader>", "<cmd>Legendary<cr>", desc = "Search Keymaps " },
  },
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
