local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (neo_scroll.lua)", vim.log.levels.WARN)
  return
end

local neoscroll_opts = settings.ui_plugins.neo_scroll
local neoscroll = {}

if neoscroll_opts.enable then
  neoscroll = {
    keys = neoscroll_opts.keys,
    "karb94/neoscroll.nvim",
    config = function()
      if vim.version().minor < 5 then
        vim.notify("Plugin [neoscroll] requires 0.5 or higher", vim.log.levels.WARN)
        return
      end

      local status_ok, neoscroll_ = pcall(require, "neoscroll")
      if not status_ok then
        vim.notify("Plugin [neoscroll] failed to load", vim.log.levels.WARN)
        return
      end
      neoscroll_.setup({
        -- All these keys will be mapped to their corresponding default scrolling animation
        mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-y>", "<C-e>", "zt", "zz", "zb" },
        hide_cursor = true, -- Hide cursor while scrolling
        stop_eof = true, -- Stop at <EOF> when scrolling downwards
        respect_scrolloff = false, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
        cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
        easing_function = nil, -- No easing function
        performance_mode = true, -- Disable "Performance Mode" on all buffers.
      })

      local t = {}
      -- Syntax: t[keys] = {function, {function arguments}}
      t["<C-u>"] = { "scroll", { "-vim.wo.scroll", "true", "250" } }
      t["<C-d>"] = { "scroll", { "vim.wo.scroll", "true", "250" } }
      t["<C-b>"] = { "scroll", { "-vim.api.nvim_win_get_height(0)", "true", "450" } }
      t["<C-f>"] = { "scroll", { "vim.api.nvim_win_get_height(0)", "true", "450" } }
      t["<C-y>"] = { "scroll", { "-0.10", "false", "100" } }
      t["<C-e>"] = { "scroll", { "0.10", "false", "100" } }
      t["zt"] = { "zt", { "250" } }
      t["zz"] = { "zz", { "250" } }
      t["zb"] = { "zb", { "250" } }

      require("neoscroll.config").set_mappings(t)
    end,
  }
end

return neoscroll
