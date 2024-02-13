local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (treesitter/comment_string.lua)", vim.log.levels.WARN)
  return
end

local ts_commentstring_opts = settings.coding_plugins.treesitter.extensions.commentstring

local treesitter_context_commentstring = {}

if ts_commentstring_opts.enable then
  treesitter_context_commentstring = {
    lazy = ts_commentstring_opts.lazy,
    event = ts_commentstring_opts.event,
    "JoosepAlviste/nvim-ts-context-commentstring",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {
      enable = true,
      enable_autocmd = false,
    },
  }
end

return treesitter_context_commentstring
