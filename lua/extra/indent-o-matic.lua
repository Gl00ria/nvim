-- use a protected call so we don't error out on first use
local status_ok, indent_o_matic = pcall(require, "indent_o_matic")
if not status_ok then
  return
end

indent_o_matic.setup {
    -- The values indicated here are the defaults

    -- Number of lines without indentation before giving up (use -1 for infinite)
    max_lines = 2048,

    -- Space indentations that should be detected
    standard_widths = { 2, 4, 8 },
}
