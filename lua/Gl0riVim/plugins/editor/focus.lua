local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (focus.lua)", vim.log.levels.WARN)
  return
end

local focus_opts = settings.editor_plugins.focus

local twilight = {}
local zenmode = {}

if focus_opts.twilight.enable then
  twilight = {
    "folke/twilight.nvim",
    keys = focus_opts.twilight.keys,
    opts = {
      {
        dimming = {
          alpha = 0.25, -- amount of dimming
          -- we try to get the foreground from the highlight groups or fallback color
          color = { "Normal", "#ffffff" },
          term_bg = "#000000", -- if guibg=NONE, this will be used to calculate text color
          inactive = false, -- when true, other windows will be fully dimmed (unless they contain the same buffer)
        },
        context = 10, -- amount of lines we will try to show around the current line
        treesitter = true, -- use treesitter when available for the filetype
        -- treesitter is used to automatically expand the visible text,
        -- but you can further control the types of nodes that should always be fully expanded
        expand = { -- for treesitter, we we always try to expand to the top-most ancestor with these types
          "function",
          "method",
          "table",
          "if_statement",
        },
        exclude = {}, -- exclude these filetypes
      },
    },
  }
end

if focus_opts.zenmode.enable then
  zenmode = {
    "folke/zen-mode.nvim",
    keys = focus_opts.zenmode.keys,
    opts = {
      {
        window = {
          backdrop = 0.95, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
          width = 120, -- width of the Zen window
          height = 1, -- height of the Zen window
          options = {
            -- signcolumn = "no", -- disable signcolumn
            -- number = false, -- disable number column
            -- relativenumber = false, -- disable relative numbers
            -- cursorline = false, -- disable cursorline
            -- cursorcolumn = false, -- disable cursor column
            -- foldcolumn = "0", -- disable fold column
            -- list = false, -- disable whitespace characters
          },
        },
        plugins = {
          options = {
            enabled = true,
            ruler = false, -- disables the ruler text in the cmd line area
            showcmd = false, -- disables the command in the last line of the screen
            laststatus = 0, -- turn off the statusline in zen mode
          },
          twilight = { enabled = false }, -- enable to start Twilight when zen mode opens
          gitsigns = { enabled = false }, -- disables git signs
          tmux = { enabled = false }, -- disables the tmux statusline
          kitty = {
            enabled = focus_opts.zenmode.terminal_support.kitty.enable,
            font = focus_opts.zenmode.terminal_support.kitty.font,
          },
          alacritty = {
            enabled = focus_opts.zenmode.terminal_support.alacritty.enabled,
            font = focus_opts.zenmode.terminal_support.alacritty.font,
          },
          wezterm = {
            enabled = focus_opts.zenmode.terminal_support.wezterm.enabled,
            font = focus_opts.zenmode.terminal_support.wezterm.font,
          },
        },
      },
    },
  }
end

return { twilight, zenmode }
