local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (yamlls.lua)", vim.log.levels.WARN)
  return
end

local yaml_opts = settings.langs_control.yaml

local lspconfig_status, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status then
  vim.notify("[lspconfig] failed to load within (yamlls.lua)", vim.log.levels.WARN)
  return
end

local yamlls = {}
local yaml_conform = {}
local yaml_mason = {}
local yaml_treesitter = {}

if yaml_opts.enable then
  yamlls = {
    lspconfig.yamlls.setup({
      capabilities = require("Gl0riVim.plugins.00_config.lsp.servers.00_handlers_capabilites").capabilities,
      handlers = require("Gl0riVim.plugins.00_config.lsp.servers.00_handlers_capabilites").handlers,
      on_attach = function(client, bufnr) end,
      schemaStore = {
        enable = true,
        url = "https://www.schemastore.org/api/json/catalog.json",
      },
      schemas = require("Gl0riVim.plugins.00_config.lsp.servers.yamlls").schemes,
      format = { enabled = false },
      validate = false,
      completion = true,
      hover = true,
    }),
  }

  if yaml_opts.mason_yaml then
    yaml_mason = {
      "mason.nvim",
      opts = function(_, opts)
        opts.ensure_installed = opts.ensure_installed or {}
        vim.list_extend(opts.ensure_installed, { "yaml-language-server", "yamllint" })
      end,
    }
  end

  if yaml_opts.conform_yaml then
    yaml_conform = {
      "stevearc/conform.nvim",
      opts = {
        formatters_by_ft = {
          ["yaml"] = { "prettier" },
        },
      },
    }
  end

  if yaml_opts.ts_yaml then
    yaml_treesitter = {
      "nvim-treesitter/nvim-treesitter",
      opts = function(_, opts)
        if type(opts.ensure_installed) == "table" then
          vim.list_extend(opts.ensure_installed, { "yaml" })
        end
      end,
    }
  end
end

return {
  yamlls,
  yaml_conform,
  yaml_mason,
  yaml_treesitter,
}
