-- use a protected call so we don't error out on first use
local status_ok, transparent = pcall(require, "transparent")
if not status_ok then
  return
end

transparent.setup({
  -- enable = true, -- boolean: enable transparent
  extra_groups = "all", -- NOTE: "all" raise an error, but works just fine

  -- extra_groups = { -- table/string: additional groups that should be clear
  --   -- In particular, when you set it to 'all', that means all avaliable groups
  --
  --   -- example of akinsho/nvim-bufferline.lua
  --   -- "BufferLineTabClose",
  --   -- "BufferlineBufferSelected",
  --   -- "BufferLineFill",
  --   -- "BufferLineBackground",
  --   -- "BufferLineSeparator",
  --   -- "BufferLineIndicatorSelected",
  -- },
  -- exclude = {}, -- table: groups you don't want to clear
})
