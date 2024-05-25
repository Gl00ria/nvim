local M = {}

M.settings = {}

M.cmd = { "vscode-html-language-server", "--stdio" }

M.filetypes = { "html" }

M.init_options = {
  configurationSection = { "html", "css", "javascript" },
  embeddedLanguages = {
    css = true,
    javascript = true,
  },
  provideFormatter = true,
}
M.single_file_support = true

return M
