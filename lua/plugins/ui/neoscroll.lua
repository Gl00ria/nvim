return {
  keys = { "<C-E>", "<C-Y>", "<C-D>", "<C-U>", "<C-B>", "<C-F>", "zb", "zt", "zz" },
  "karb94/neoscroll.nvim",
  config = function()
    local function open_file_under_cursor_in_the_panel_above()
      local target = vim.fn.expand("<cfile>")
      local full_path_with_suffix = vim.fn.expand("<cWORD>")
      local telescope = require("telescope.builtin")

      vim.api.nvim_command("wincmd k")

      if vim.loop.fs_stat(target) then
        vim.api.nvim_command(string.format("e %s", full_path_with_suffix))
      elseif telescope then
        telescope.find_files {
          prompt_prefix = "🪿 ",
          default_text = full_path_with_suffix,
          wrap_results = true,
          find_command = { "rg", "--files", "--no-require-git" },
        }
      else
        error(string.format("File %s does not exist", target))
      end
    end

    -- Opens file under cursor in the panel above
    vim.keymap.set("n", "gf", open_file_under_cursor_in_the_panel_above, { silent = true })
    if vim.version().minor < 5 then
      vim.notify("Plugin [neoscroll] requires 0.5 or higher", vim.log.levels.WARN)
      return
    end

    local status_ok, neoscroll_ = pcall(require, "neoscroll")
    if not status_ok then
      vim.notify("Plugin [neoscroll] failed to load", vim.log.levels.WARN)
      return
    end
    neoscroll_.setup {
      -- All these keys will be mapped to their corresponding default scrolling animation
      hide_cursor = true, -- Hide cursor while scrolling
      stop_eof = true, -- Stop at <EOF> when scrolling downwards
      respect_scrolloff = false, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
      cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
      easing_function = nil, -- No easing function
      performance_mode = true, -- Disable "Performance Mode" on all buffers.
    }

    local keymap = {
      ["<C-u>"] = function() neoscroll_.ctrl_u { duration = 250 } end,
      ["<C-d>"] = function() neoscroll_.ctrl_d { duration = 250 } end,
      ["<C-b>"] = function() neoscroll_.ctrl_b { duration = 450 } end,
      ["<C-f>"] = function() neoscroll_.ctrl_f { duration = 450 } end,
      ["<C-y>"] = function() neoscroll_.scroll(-0.1, { move_cursor = false, duration = 100 }) end,
      ["<C-e>"] = function() neoscroll_.scroll(0.1, { move_cursor = false, duration = 100 }) end,
      ["zt"] = function() neoscroll_.zt { half_win_duration = 250 } end,
      ["zz"] = function() neoscroll_.zz { half_win_duration = 250 } end,
      ["zb"] = function() neoscroll_.zb { half_win_duration = 250 } end,
    }
    local modes = { "n", "v", "x" }
    for key, func in pairs(keymap) do
      vim.keymap.set(modes, key, func)
    end
  end,
}
