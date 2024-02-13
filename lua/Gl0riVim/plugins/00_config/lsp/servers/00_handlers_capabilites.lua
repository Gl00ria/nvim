-- sharing common handlers & capabilities beteewn servers, no need to write them over and over again
local M = {}
local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify(
    "[settings] failed to load within (00_config/lsp/servers/00_handlers_capabilites.lua)",
    vim.log.levels.WARN
  )
  return
end

local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
M.capabilities = {
  capabilities.textDocument.completion.completionItem.snippetSupport == true,
  capabilities.textDocument.completion.completionItem.resolveSupport == {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  },
  capabilities.textDocument.foldingRange == {
    dynamicRegistration = false,
    lineFoldingOnly = true,
  },
}

M.handlers = {
  ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    silent = true,
    border = "rounded",
  }),
  ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
  ["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics,
    { virtual_text = settings.virtual_text }
  ),
}

return M
