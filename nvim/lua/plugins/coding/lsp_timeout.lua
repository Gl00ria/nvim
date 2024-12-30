return {
  "hinell/lsp-timeout.nvim",
  event = "LspAttach",
  config = function()
    vim.g["lspTimeoutConfig"] = {
      -- wait 5 minutes before stopping all LSP servers
      stopTimeout = 1000 * 60 * 5,
      startTimeout = 1000 * 10,
      silent = true,
    }
  end,
}
