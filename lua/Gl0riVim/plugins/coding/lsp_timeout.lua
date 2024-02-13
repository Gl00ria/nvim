local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (lsp_timeout.lua)", vim.log.levels.WARN)
  return
end

local timout_opts = settings.coding_plugins.lsp_timeout

local lsp_timeout = {}

if timout_opts.enable then
  lsp_timeout = {
    event = timout_opts.event,
    "hinell/lsp-timeout.nvim",
    dependencies = { "neovim/nvim-lspconfig" },
    config = function()
      vim.g["lspTimeoutConfig"] = {
        -- wait 5 minutes before stopping all LSP servers
        stopTimeout = timout_opts.stopTimeout,
        startTimeout = timout_opts.startTimeout,
        silent = timout_opts.silent,
      }
    end,
  }
end

return lsp_timeout
