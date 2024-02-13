local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (vuels.lua)", vim.log.levels.WARN)
  return
end

local vue_opts = settings.langs_control.vue

local lspconfig_status, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status then
  vim.notify("[lspconfig] failed to load within (vuels.lua)", vim.log.levels.WARN)
  return
end

local vuels = {}
local vue_conform = {}
local vuels_mason = {}
local vue_treeistter = {}

if vue_opts.enable then
  vuels = {
    lspconfig.vuels.setup({
      init_options = require("Gl0riVim.plugins.00_config.lsp.servers.vuels").init_options,
      on_attach = require("Gl0riVim.plugins.00_config.lsp.servers.vuels").on_attach,
      handlers = require("Gl0riVim.plugins.00_config.lsp.servers.00_handlers_capabilites").handlers,
      filetypes = require("Gl0riVim.plugins.00_config.lsp.servers.vuels").filetypes,
    }),
  }

  if vue_opts.mason_vue then
    vuels_mason = {
      "mason.nvim",
      opts = function(_, opts)
        opts.ensure_installed = opts.ensure_installed or {}
        vim.list_extend(opts.ensure_installed, { "vue-language-server" })
      end,
    }
  end

  if vue_opts.conform_vue then
    vue_conform = {
      "stevearc/conform.nvim",
      opts = {
        formatters_by_ft = {
          ["vue"] = { "prettier" },
        },
      },
    }
  end
  if vue_opts.ts_vue then
    vue_treeistter = {
      "nvim-treesitter/nvim-treesitter",
      opts = function(_, opts)
        if type(opts.ensure_installed) == "table" then
          vim.list_extend(opts.ensure_installed, { "vue" })
        end
      end,
    }
  end
end

return {
  vuels,
  vuels_mason,
  vue_conform,
  vue_treeistter,
}
