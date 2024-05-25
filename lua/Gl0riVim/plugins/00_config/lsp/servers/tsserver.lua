local M = {}

local filter = require("Gl0riVim.plugins.00_config.lsp.utils.filter").filter
local filterReactDTS = require("Gl0riVim.plugins.00_config.lsp.utils.filterreactDTS").filterReactDTS
local baseDefinitionHandler = vim.lsp.handlers["textDocument/definition"]

local on_attach = function(client, bufnr)
  -- Modifying a server's capabilities is not recommended and is no longer
  -- necessary thanks to the `vim.lsp.buf.format` API introduced in Neovim
  -- 0.8. Users with Neovim 0.7 needs to uncomment below lines to make tsserver formatting work (or keep using eslint).

  -- client.server_capabilities.documentFormattingProvider = false
  -- client.server_capabilities.documentRangeFormattingProvider = false

  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end

  buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

  require("lsp-inlayhints").on_attach(client, bufnr)
end

M.typescript_tools_on_attach = function(client, bufnr)
  if vim.fn.has("nvim-0.10") then
    -- Enable inlay hints
    vim.lsp.inlay_hint(bufnr, true)
  end
end

M.typescript_tools_handlers = {
  ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    silent = true,
    border = "rounded",
  }),
  ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
  ["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics,
    { virtual_text = true }
  ),
  ["textDocument/definition"] = function(err, result, method, ...)
    P(result)
    if vim.islist(result) and #result > 1 then
      local filtered_result = filter(result, filterReactDTS)
      return baseDefinitionHandler(err, filtered_result, method, ...)
    end

    baseDefinitionHandler(err, result, method, ...)
  end,
}

local lspconfig_status, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status then
  vim.notify(
    "[lspconfig] failed to load within (00_config/lsp/servers/tsserver.lua) from ts_server_choice",
    vim.log.levels.WARN
  )
  return
end

M.settings = {
  cmd = { "typescript-language-server", "--stdio" },
  root_dir = lspconfig.util.root_pattern("tsconfig.json", "package.json", "jsconfig.json", ".git"),
  init_options = {
    preferences = {
      disableSuggestions = true,
    },
  },
  filetypes = {
    "html",
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
    "vue",
  },
  typescript = {
    inlayHints = {
      includeInlayParameterNameHints = "all",
      includeInlayParameterNameHintsWhenArgumentMatchesName = false,
      includeInlayFunctionParameterTypeHints = true,
      includeInlayVariableTypeHints = false,
      includeInlayPropertyDeclarationTypeHints = true,
      includeInlayFunctionLikeReturnTypeHints = false,
      includeInlayEnumMemberValueHints = true,
    },
    suggest = {
      includeCompletionsForModuleExports = true,
    },
  },
  javascript = {
    inlayHints = {
      includeInlayParameterNameHints = "all",
      includeInlayParameterNameHintsWhenArgumentMatchesName = false,
      includeInlayFunctionParameterTypeHints = true,
      includeInlayVariableTypeHints = false,
      includeInlayPropertyDeclarationTypeHints = true,
      includeInlayFunctionLikeReturnTypeHints = false,
      includeInlayEnumMemberValueHints = true,
    },
    suggest = {
      includeCompletionsForModuleExports = true,
    },
  },
}

M.on_attach = on_attach

return M
