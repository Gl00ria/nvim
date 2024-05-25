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

if settings.langs_control.html_css.enable_emmetls then
  emmetls = {
    lspconfig.emmet_ls.setup({
      capabilities = require("Gl0riVim.plugins.00_config.lsp.servers.00_handlers_capabilites").capabilities,
      handlers = require("Gl0riVim.plugins.00_config.lsp.servers.00_handlers_capabilites").handlers,
      filetypes = {
        "css",
        "eruby",
        "html",
        -- "javascript",
        "javascriptreact",
        "less",
        "sass",
        "scss",
        "svelte",
        "pug",
        "typescriptreact",
        "vue",
      },
      init_options = {
        --- @type string[]
        excludeLanguages = {},
        --- @type string[]
        extensionsPath = {},
        --- @type table<string, any> [Emmet Docs](https://docs.emmet.io/customization/preferences/)
        preferences = {},
        --- @type boolean Defaults to `true`
        showAbbreviationSuggestions = true,
        --- @type "always" | "never" Defaults to `"always"`
        showExpandedAbbreviation = "always",
        --- @type boolean Defaults to `false`
        showSuggestionsAsSnippets = false,
        --- @type table<string, any> [Emmet Docs](https://docs.emmet.io/customization/syntax-profiles/)
        syntaxProfiles = {},
        --- @type table<string, string> [Emmet Docs](https://docs.emmet.io/customization/snippets/#variables)
        variables = {},
      },
    }),
  }
  if settings.langs_control.html_css.mason_emmitls then
    emmetls_mason = {
      "mason.nvim",
      opts = function(_, opts)
        opts.ensure_installed = opts.ensure_installed or {}
        vim.list_extend(opts.ensure_installed, { "emmet-language-server" })
      end,
    }
  end
end

return { emmetls, emmetls_mason }
