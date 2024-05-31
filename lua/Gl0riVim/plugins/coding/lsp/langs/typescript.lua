local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (typescript.lua)", vim.log.levels.WARN)
  return
end

local typescript_opts = settings.langs_control.typescript
local mason_ts = {}
local ts_err_trans = {}
local ts_server = {}

if typescript_opts.typescript_type == "tools" then
  ts_server = {
    "pmizio/typescript-tools.nvim",
    -- event = { "BufReadPre", "BufNewFile" },
    ft = { "typescript", "typescriptreact" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "neovim/nvim-lspconfig",
    },
    opts = {
      on_attach = require("Gl0riVim.plugins.00_config.lsp.servers.tsserver").typescript_tools_on_attach,
      handlers = require("Gl0riVim.plugins.00_config.lsp.servers.tsserver").typescript_tools_handlers,
      settings = {
        separate_diagnostic_server = true,
        tsserver_file_preferences = {
          includeInlayParameterNameHints = "all",
          includeCompletionsForModuleExports = true,
          quotePreference = "auto",
        },
      },
    },
  }
elseif typescript_opts.typescript_type == "tsserver" then
  local function ts_server_choice()
    -- local table_contains = require("util").table_contains
    -- local formatters_linters = settings.formatters_linters
    local api = vim.api

    -- make sure to only run this once!
    -- local formatter_bin = "eslint_d"
    -- if table_contains("prettier") then
    --   formatter_bin = "prettier"
    -- end
    local tsserver_on_attach = function(client, bufnr)
      -- disable tsserver formatting if you plan on formatting via null-ls or conform
      client.server_capabilities.document_formatting = false
      client.server_capabilities.document_range_formatting = false

      local ts_utils = require("nvim-lsp-ts-utils")

      -- defaults
      ts_utils.setup({
        enable_import_on_completion = true,
        -- eslint
        eslint_enable_code_actions = true,
        eslint_enable_disable_comments = true,
        eslint_bin = "eslint_d",
        eslint_enable_diagnostics = false,
        eslint_opts = {},
        -- formatting
        enable_formatting = true,
        formatter = "prettier",
        formatter_opts = {},
        -- update imports on file move
        update_imports_on_move = true,
        require_confirmation_on_move = false,
        watch_dir = nil,
        -- filter diagnostics
        filter_out_diagnostics_by_severity = {},
        filter_out_diagnostics_by_code = {},
      })

      -- required to fix code action ranges and filter diagnostics
      ts_utils.setup_client(client)

      -- no default maps, so you may want to define some here
      local opts = { silent = true }
      api.nvim_buf_set_keymap(bufnr, "n", typescript_opts.keys.ts_organize, ":TSLspOrganize<CR>", opts)
      api.nvim_buf_set_keymap(bufnr, "n", typescript_opts.keys.ts_reaname_file, ":TSLspRenameFile<CR>", opts)
      api.nvim_buf_set_keymap(bufnr, "n", typescript_opts.keys.ts_import_all, ":TSLspImportAll<CR>", opts)
    end

    local lspconfig_status, lspconfig = pcall(require, "lspconfig")
    if not lspconfig_status then
      vim.notify("[lspconfig] failed to load within (langs/typescript.lua) from ts_server_choice", vim.log.levels.WARN)
      return
    end

    lspconfig.tsserver.setup({
      capabilities = require("Gl0riVim.plugins.00_config.lsp.servers.00_handlers_capabilites").capabilities,
      handlers = require("Gl0riVim.plugins.00_config.lsp.servers.00_handlers_capabilites").handlers,
      settings = require("Gl0riVim.plugins.00_config.lsp.servers.tsserver").settings,
      on_attach = tsserver_on_attach,
    })

    if typescript_opts.mason_ts then
      mason_ts = {
        "mason.nvim",
        opts = function(_, opts)
          opts.ensure_installed = opts.ensure_installed or {}
          vim.list_extend(opts.ensure_installed, { "typescript-language-server" })
        end,
      }
    end

    if typescript_opts.ts_error_translator then
      ts_err_trans = {
        "dmmulroy/ts-error-translator.nvim",
        config = function()
          require("ts-error-translator").setup()
        end,
      }
    end
  end

  ts_server = {
    ts_server_choice(),
  }
end

local tsc = {}
if typescript_opts.enable_tsc then
  tsc = {
    "dmmulroy/tsc.nvim",
    cmd = { "TSC" },
    config = true,
  }
end

local template_string = {}
if typescript_opts.enable_template_string then
  template_string = {
    "axelvc/template-string.nvim",
    ft = {
      "javascript",
      "typescript",
      "javascriptreact",
      "typescriptreact",
    },
    config = function()
      local termplate_status, temp_string = pcall(require, "template-string")
      if not termplate_status then
        vim.notify("Plugin [template-string] failed to load within (typescript.lua)", vim.log.levels.WARN)
        return
      end
      temp_string.setup()
    end,
  }
end

local typescript_treesitter = {}
if typescript_opts.ts_typscript then
  typescript_treesitter = {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, {
          "typescript",
          "javascript",
          "svelte",
          "tsx",
        })
      end
    end,
  }
end

local typescript_conform = {}
if typescript_opts.conform_typescript then
  typescript_conform = {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        ["javascript"] = { "prettier" },
        ["javascriptreact"] = { "prettier" },
        ["typescript"] = { "prettier" },
        ["typescriptreact"] = { "prettier" },
      },
    },
  }
end

return {
  ts_server,
  mason_ts,
  ts_err_trans,
  tsc,
  template_string,
  typescript_treesitter,
  typescript_conform,
}
