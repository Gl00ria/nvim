local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (vimls.lua)", vim.log.levels.WARN)
  return
end

local vim_opts = settings.langs_control.vimls

local lspconfig_status, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status then
  vim.notify("[lspconfig] failed to load within (vimls.lua)", vim.log.levels.WARN)
  return
end

local vim_ls = {}
local mason_vimls = {}
local vim_treesitter = {}
if vim_opts.enable then
  vim_ls = {
    lspconfig.vimls.setup({
      capabilities = require("Gl0riVim.plugins.00_config.lsp.servers.00_handlers_capabilites").capabilities,
      flags = {
        debounce_text_changes = 500,
      },
    }),
  }

  if vim_opts.mason_vim then
    mason_vimls = {
      "mason.nvim",
      opts = function(_, opts)
        opts.ensure_installed = opts.ensure_installed or {}
        vim.list_extend(opts.ensure_installed, { "vim-language-server" })
      end,
    }
  end

  if vim_opts.ts_vim then
    vim_treesitter = {
      "nvim-treesitter/nvim-treesitter",
      opts = function(_, opts)
        if type(opts.ensure_installed) == "table" then
          vim.list_extend(opts.ensure_installed, { "vim", "vimdoc" })
        end
      end,
    }
  end
end

return {
  vim_ls,
  mason_vimls,
  vim_treesitter,
}
