local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (graphql.lua)", vim.log.levels.WARN)
  return
end

local graphql_opts = settings.langs_control.graphql

local lspconfig_status, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status then
  vim.notify("[lspconfig] failed to load within (graphql.lua)", vim.log.levels.WARN)
  return
end

local graphql = {}
local sqlls_mason = {}
local graphql_conform = {}
local graphql_treesitter = {}
if graphql_opts.enable then
  graphql = {
    lspconfig.graphql.setup({
      settings = require("Gl0riVim.plugins.00_config.lsp.servers.graphql").settings,
      filetypes = require("Gl0riVim.plugins.00_config.lsp.servers.graphql").filetypes,
      capabilities = require("Gl0riVim.plugins.00_config.lsp.servers.00_handlers_capabilites").capabilities,
      handlers = require("Gl0riVim.plugins.00_config.lsp.servers.00_handlers_capabilites").handlers,
    }),
  }

  if graphql_opts.conform_graphql then
    graphql_conform = {
      "stevearc/conform.nvim",
      opts = {
        formatters_by_ft = {
          ["graphql"] = { "prettier" },
        },
      },
    }
  end

  if graphql_opts.mason_sqlls then
    sqlls_mason = {
      "mason.nvim",
      opts = function(_, opts)
        opts.ensure_installed = opts.ensure_installed or {}
        vim.list_extend(opts.ensure_installed, { "sqlls" })
      end,
    }
  end

  if graphql_opts.ts_graphql then
    graphql_treesitter = {
      "nvim-treesitter/nvim-treesitter",
      opts = function(_, opts)
        if type(opts.ensure_installed) == "table" then
          vim.list_extend(opts.ensure_installed, { "graphql", "query" })
        end
      end,
    }
  end
end

return {
  graphql,
  graphql_conform,
  sqlls_mason,
  graphql_treesitter,
}
