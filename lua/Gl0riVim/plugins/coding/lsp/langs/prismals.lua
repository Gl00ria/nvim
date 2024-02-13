local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (prismals.lua)", vim.log.levels.WARN)
  return
end

local lspconfig_status, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status then
  vim.notify("[lspconfig] failed to load within (prismals.lua)", vim.log.levels.WARN)
  return
end

local prisma_opts = settings.langs_control.prisma

local prismals = {}
local treesitter_prisma = {}
local mason_prisma = {}

if prisma_opts.enable then
  prismals = {
    lspconfig.html.setup({
      settings = require("Gl0riVim.plugins.00_config.lsp.servers.html").settings,
      capabilities = require("Gl0riVim.plugins.00_config.lsp.servers.00_handlers_capabilites").capabilities,
      handlers = require("Gl0riVim.plugins.00_config.lsp.servers.00_handlers_capabilites").handlers,
    }),
  }
  if prisma_opts.ts_prisma then
    treesitter_prisma = {
      "nvim-treesitter/nvim-treesitter",
      opts = function(_, opts)
        if type(opts.ensure_installed) == "table" then
          vim.list_extend(opts.ensure_installed, {
            "prisma",
          })
        end
      end,
    }
  end

  if prisma_opts.mason_prsima then
    mason_prisma = {
      "mason.nvim",
      opts = function(_, opts)
        opts.ensure_installed = opts.ensure_installed or {}
        vim.list_extend(opts.ensure_installed, { "prisma-language-server" })
      end,
    }
  end
end

return {
  prismals,
  treesitter_prisma,
  mason_prisma,
}
