local M = {}

M.root_dir = function(fname)
  return require("lspconfig.util").root_pattern(
    "Makefile",
    "configure.ac",
    "configure.in",
    "config.h.in",
    "meson.build",
    "meson_options.txt",
    "build.ninja"
  )(fname) or require("lspconfig.util").root_pattern("compile_commands.json", "compile_flags.txt")(fname) or require(
    "lspconfig.util"
  ).find_git_ancestor(fname)
end

local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
M.capabilities = {
  capabilities.offsetEncoding == "utf-16",
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

M.cmd = {
  "clangd",
  "--background-index",
  "--clang-tidy",
  "--header-insertion=iwyu",
  "--completion-style=detailed",
  "--function-arg-placeholders",
  "--fallback-style=llvm",
}

return M
