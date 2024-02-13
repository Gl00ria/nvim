local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (jsonls.lua)", vim.log.levels.WARN)
  return
end

local json_opts = settings.langs_control.json

local lspconfig_status, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status then
  vim.notify("[lspconfig] failed to load within (jsonls.lua)", vim.log.levels.WARN)
  return
end

local jsonls = {}
local json_mason = {}
local json_conform = {}
local json_treesitter = {}

if json_opts.enable then
  jsonls = {
    lspconfig.jsonls.setup({
      capabilities = require("Gl0riVim.plugins.00_config.lsp.servers.00_handlers_capabilites").capabilities,
      handlers = require("Gl0riVim.plugins.00_config.lsp.servers.00_handlers_capabilites").handlers,
      settings = require("Gl0riVim.plugins.00_config.lsp.servers.jsonls").settings,
      -- settings = {
      --     json = {
      --         schemas = require("schemastore").json.schemas(),
      --     },
      -- },
    }),
  }

  if json_opts.mason_json then
    json_mason = {
      "mason.nvim",
      opts = function(_, opts)
        opts.ensure_installed = opts.ensure_installed or {}
        vim.list_extend(opts.ensure_installed, { "json-lsp" })
      end,
    }
  end

  if json_opts.conform_json then
    json_conform = {
      "stevearc/conform.nvim",
      opts = {
        formatters_by_ft = {
          ["json"] = { "prettier" },
          ["jsonc"] = { "prettier" },
        },
      },
    }
  end

  if json_opts.ts_json then
    json_treesitter = {
      "nvim-treesitter/nvim-treesitter",
      opts = function(_, opts)
        if type(opts.ensure_installed) == "table" then
          vim.list_extend(opts.ensure_installed, {
            "json",
            "json5",
            "jsonc",
          })
        end
      end,
    }
  end
end

return {
  jsonls,
  json_mason,
  json_conform,
  json_treesitter,
}
