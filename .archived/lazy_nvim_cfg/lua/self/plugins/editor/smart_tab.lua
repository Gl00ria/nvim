return {
  "boltlessengineer/smart-tab.nvim",
  event = "VeryLazy",
  opts = {
    -- default options:
    -- list of tree-sitter node types to filter
    skips = { "string_content" },
    -- default mapping, set `false` if you don't want automatic mapping
    mapping = "<C-t>",
  },
}
