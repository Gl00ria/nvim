local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (hlchunk.lua)", vim.log.levels.WARN)
  return
end

local chunk_opts = settings.utils_plugins.hl_chunk
local chunk = {}

if chunk_opts.enable then
  chunk = {
    "Mr-LLLLL/cool-chunk.nvim",
    event = chunk_opts.event,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("cool-chunk").setup({})
    end,
  }
end

return chunk
