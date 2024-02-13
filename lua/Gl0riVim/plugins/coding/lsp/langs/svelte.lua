local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (svelte.lua)", vim.log.levels.WARN)
  return
end

local svelte_opts = settings.langs_control.svelte

local lspconfig_status, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status then
  vim.notify("[lspconfig] failed to load within (svelte.lua)", vim.log.levels.WARN)
  return
end

local svelte = {}
local mason_svelte = {}
local treesitter_svelte = {}

if svelte_opts.enable then
  svelte = {
    lspconfig.html.setup({
      capabilities = require("Gl0riVim.plugins.00_config.lsp.servers.00_handlers_capabilites").capabilities,
      handlers = require("Gl0riVim.plugins.00_config.lsp.servers.00_handlers_capabilites").handlers,
      on_attach = require("Gl0riVim.plugins.00_config.lsp.servers.sevelte").on_attach,
    }),
  }

  if svelte_opts.mason_svelte then
    mason_svelte = {
      "mason.nvim",
      opts = function(_, opts)
        opts.ensure_installed = opts.ensure_installed or {}
        vim.list_extend(opts.ensure_installed, { "svelte-language-server" })
      end,
    }
  end

  if svelte_opts.ts_svelte then
    treesitter_svelte = {
      "nvim-treesitter/nvim-treesitter",
      opts = function(_, opts)
        if type(opts.ensure_installed) == "table" then
          vim.list_extend(opts.ensure_installed, { "svelte" })
        end
      end,
    }
  end
end

return {
  svelte,
  mason_svelte,
  treesitter_svelte,
}
