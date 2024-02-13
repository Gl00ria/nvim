local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (eslint.lua)", vim.log.levels.WARN)
  return
end

local eslint_opts = settings.langs_control.eslint

local eslint = {}
local mason_eslint = {}

local lspconfig_status, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status then
  vim.notify("[lspconfig] failed to load within (eslint.lua)", vim.log.levels.WARN)
  return
end

if eslint_opts.enable then
  eslint = {
    lspconfig.eslint.setup({
      on_attach = require("Gl0riVim.plugins.00_config.lsp.servers.eslint").on_attach,
      settings = require("Gl0riVim.plugins.00_config.lsp.servers.eslint").settings,
      cmd = { "vscode-eslint-language-server", "--stdio" },
      capabilities = require("Gl0riVim.plugins.00_config.lsp.servers.00_handlers_capabilites").capabilities,
      handlers = require("Gl0riVim.plugins.00_config.lsp.servers.00_handlers_capabilites").handlers,
      filetypes = require("Gl0riVim.plugins.00_config.lsp.servers.eslint").filetypes,
      root_dir = require("lspconfig.util").root_pattern(".git"),
    }),
  }

  if eslint_opts.mason_eslint then
    mason_eslint = {
      "mason.nvim",
      opts = function(_, opts)
        opts.ensure_installed = opts.ensure_installed or {}
        vim.list_extend(opts.ensure_installed, { "eslint_d" })
      end,
    }
  end
end

return { eslint, mason_eslint }
