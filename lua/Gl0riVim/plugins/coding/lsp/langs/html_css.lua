local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (html.lua)", vim.log.levels.WARN)
  return
end

local html_css_opts = settings.langs_control.html_css

local lspconfig_status, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status then
  vim.notify("[lspconfig] failed to load within (html.lua)", vim.log.levels.WARN)
  return
end

local html = {}
local htmx = {}
local css = {}
local html_conform = {}
local css_conform = {}
local cssmodules_ls_mason = {}
local html_css_treesitter = {}

if html_css_opts.enable_html then
  html = {
    lspconfig.html.setup({
      cmd = require("Gl0riVim.plugins.00_config.lsp.servers.html").cmd,
      filetypes = require("Gl0riVim.plugins.00_config.lsp.servers.html").filetypes,
      init_options = require("Gl0riVim.plugins.00_config.lsp.servers.html").init_options,
      single_file_support = require("Gl0riVim.plugins.00_config.lsp.servers.html").single_file_support,
      settings = require("Gl0riVim.plugins.00_config.lsp.servers.html").settings,
      capabilities = require("Gl0riVim.plugins.00_config.lsp.servers.00_handlers_capabilites").capabilities,
      handlers = require("Gl0riVim.plugins.00_config.lsp.servers.00_handlers_capabilites").handlers,
    }),
  }

  if html_css_opts.conform_html then
    html_conform = {
      "stevearc/conform.nvim",
      opts = {
        formatters_by_ft = {
          ["html"] = { "prettier" },
        },
      },
    }
  end
end

if html_css_opts.enable_htmx then
  htmx = {
    lspconfig.htmx.setup({
      cmd = { "htmx-lsp" },
      filetypes = { "html" },
      single_file_support = true,
    }),
  }
end

local tailwindcss = {}
if html_css_opts.mason_tailwind then
  tailwindcss = {
    {
      "mason.nvim",
      opts = function(_, opts)
        opts.ensure_installed = opts.ensure_installed or {}
        vim.list_extend(opts.ensure_installed, { "tailwindcss-language-server", "astro-language-server" })
      end,
    },
    lspconfig.tailwindcss.setup({
      cmd = require("Gl0riVim.plugins.00_config.lsp.servers.tailwindcss").cmd,
      root_dir = require("Gl0riVim.plugins.00_config.lsp.servers.tailwindcss").root_dir,
      on_attach = require("Gl0riVim.plugins.00_config.lsp.servers.tailwindcss").on_attach,
      capabilities = require("Gl0riVim.plugins.00_config.lsp.servers.00_handlers_capabilites").capabilities,
      handlers = require("Gl0riVim.plugins.00_config.lsp.servers.00_handlers_capabilites").handlers,
      filetypes = require("Gl0riVim.plugins.00_config.lsp.servers.tailwindcss").filetypes,
      filetypes_exclude = { "markdown" },
      init_options = require("Gl0riVim.plugins.00_config.lsp.servers.tailwindcss").init_options,
      settings = require("Gl0riVim.plugins.00_config.lsp.servers.tailwindcss").settings,
    }),
  }
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

if html_css_opts.enable_css then
  css = {
    lspconfig.cssls.setup({
      require("Gl0riVim.plugins.00_config.lsp.servers.cssls").capabilities,
      handlers = require("Gl0riVim.plugins.00_config.lsp.servers.00_handlers_capabilites").handlers,
      on_attach = require("Gl0riVim.plugins.00_config.lsp.servers.cssls").on_attach,
      settings = require("Gl0riVim.plugins.00_config.lsp.servers.cssls").settings,
      root_dir = lspconfig.util.root_pattern("package.json", ".git"),
    }),
  }

  if html_css_opts.mason_cssmodules then
    cssmodules_ls_mason = {
      {
        "mason.nvim",
        opts = function(_, opts)
          opts.ensure_installed = opts.ensure_installed or {}
          -- vim.list_extend(opts.ensure_installed, { "cssmodules-language-server" })
          vim.list_extend(opts.ensure_installed, { "htmx-lsp", "html-lsp", "css-lsp" })
        end,
      },
    }
  end

  if html_css_opts.conform_css then
    css_conform = {
      "stevearc/conform.nvim",
      opts = {
        formatters_by_ft = {
          ["css"] = { "prettier" },
        },
      },
    }
  end
end

if html_css_opts.ts_html_css then
  html_css_treesitter = {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "html", "css" })
      end
    end,
  }
end
return {
  html,
  htmx,
  html_conform,
  tailwindcss,
  css,
  css_conform,
  html_css_treesitter,
  cssmodules_ls_mason,
}
