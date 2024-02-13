local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (emmetls.lua)", vim.log.levels.WARN)
  return
end

local lspconfig_status, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status then
  vim.notify("[lspconfig] failed to load within (emmetls.lua)", vim.log.levels.WARN)
  return
end

local emmetls = {}
local emmetls_mason = {}

if settings.enable_langs_emmetls then
  emmetls = {
    lspconfig.emmet_ls.setup({
      capabilities = require("Gl0riVim.plugins.00_config.lsp.servers.00_handlers_capabilites").capabilities,
      handlers = require("Gl0riVim.plugins.00_config.lsp.servers.00_handlers_capabilites").handlers,
      filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
    }),
  }
  if settings.enable_emmetls_mason then
    emmetls_mason = {
      "mason.nvim",
      opts = function(_, opts)
        opts.ensure_installed = opts.ensure_installed or {}
        vim.list_extend(opts.ensure_installed, { "emmet-ls" })
      end,
    }
  end
end

return {
  emmetls,
  emmetls_mason,
}
