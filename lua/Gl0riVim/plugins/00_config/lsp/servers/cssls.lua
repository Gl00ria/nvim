local M = {}

M.settings = {
  css = {
    validate = true,
    -- lint = {
    --   unknownAtRules = "ignore",
    -- },
  },
  less = {
    validate = true,
  },
  scss = {
    validate = true,
    lint = {
      unknownAtRules = "ignore",
    },
  },
  single_file_support = true,
}

M.on_attach = function(client)
  client.server_capabilities.documentFormattingProvider = true
  client.server_capabilities.documentRangeFormattingProvider = true
end

M.capabilities = function()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
end

return M
