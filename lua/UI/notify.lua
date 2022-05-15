-- use plenary's async library to avoid using callbacks
local async = require("plenary.async")
local notify = require("notify").async

async.run(function()
  notify("Welcome to Neovim, Sync...").events.close()
  notify("Done!")
end)


-- use a protected call so we don't error out on first use
local status_ok, notify = pcall(require, "notify")
if not status_ok then
  return
end


local icons = require "icons"

notify.setup {
  -- Animation style (see below for details)
  stages = "fade_in_slide_out",

  -- Function called when a new window is opened, use for changing win settings/config
  on_open = nil,

  -- Function called when a window is closed
  on_close = nil,

  -- Render function for notifications. See notify-render()
  render = "default",

  -- Default timeout for notifications
  timeout = 5000,

  -- For stages that change opacity this is treated as the highlight behind the window
  -- Set this to either a highlight group or an RGB hex value e.g. "#000000"
  background_colour = "#000000",

  -- Minimum width for notification windows
  minimum_width = 10,

  -- Icons for the different levels
  icons = {
    ERROR = icons.diagnostics.Error,
    WARN = icons.diagnostics.Warning,
    INFO = icons.diagnostics.Information,
    DEBUG = icons.ui.Bug,
    TRACE = icons.ui.Pencil,
  },
}

vim.notify = notify
