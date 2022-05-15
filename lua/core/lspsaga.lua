-- use a protected call so we don't error out on first use
local config_status_ok, lspsaga = pcall(require, "lspsaga")
if not config_status_ok then
  return
end

local icons = require "icons"

lspsaga.setup { -- defaults ...
  debug = false,
  use_saga_diagnostic_sign = true,
  -- diagnostic sign
  error_sign = icons.diagnostics.Error,
  warn_sign = icons.diagnostics.Warning,
  hint_sign = icons.diagnostics.Hint,
  infor_sign = icons.diagnostics.Information,
  diagnostic_header_icon = icons.ui.Bug,
  -- code action title icon
  code_action_icon = icons.ui.Fire,
  code_action_prompt = {
    enable = false,
    sign = true,
    sign_priority = 40,
    virtual_text = true,
  },
  finder_definition_icon = "  ",
  finder_reference_icon = "  ",
  max_preview_lines = 10,
  finder_action_keys = {
    open = "o",
    vsplit = "s",
    split = "i",
    quit = "q",
    scroll_down = "<C-f>",
    scroll_up = "<C-b>",
  },
  code_action_keys = {
    quit = "q",
    exec = "<cr>",
  },
  rename_action_keys = {
    quit = "<C-c>",
    exec = "<cr>",
  },
  definition_preview_icon = "  ",
  border_style = "single",
  rename_prompt_prefix = "➤",
  rename_output_qflist = {
    enable = false,
    auto_open_qflist = false,
  },
  server_filetype_map = {},
  diagnostic_prefix_format = "%d. ",
  diagnostic_message_format = "%m %c",
  highlight_prefix = false,
}
