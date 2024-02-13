local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (shells.lua)", vim.log.levels.WARN)
  return
end

local shells_opts = settings.langs_control.shells

local table_contains = require("Gl0riVim.config.utils").table_contains

local lspconfig_status, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status then
  vim.notify("[lspconfig] failed to load within (langs/shells.lua)", vim.log.levels.WARN)
  return
end

local shell_server = { "bash-language-server", "shellcheck" }
local function client_check()
  if table_contains(shell_server, "bashls") then
    -- Enable/Disable shellcheck in bashls
    local bashls_settings = {
      bashIde = {
        backgroundAnalysisMaxFiles = 500,
        enableSourceErrorDiagnostics = false,
        explainshellEndpoint = "",
        globPattern = vim.env.GLOB_PATTERN or "*@(.sh|.inc|.bash|.command)",
        includeAllWorkspaceSymbols = false,
        logLevel = "info",
        shellcheckArguments = "",
        shellcheckPath = vim.env.SHELLCHECK_PATH or "",
      },
    }

    if table_contains(shell_server, "shellcheck") then
      bashls_settings = {
        bashIde = {
          backgroundAnalysisMaxFiles = 500,
          enableSourceErrorDiagnostics = false,
          explainshellEndpoint = "",
          globPattern = vim.env.GLOB_PATTERN or "*@(.sh|.inc|.bash|.command)",
          includeAllWorkspaceSymbols = false,
          logLevel = "info",
          shellcheckArguments = "",
          shellcheckPath = vim.env.SHELLCHECK_PATH or "shellcheck",
        },
      }
    end
    lspconfig.bashls.setup({
      capabilities = require("Gl0riVim.plugins.00_config.lsp.servers.00_handlers_capabilites").capabilities,
      handlers = require("Gl0riVim.plugins.00_config.lsp.servers.00_handlers_capabilites").handlers,
      filetypes = { "sh", "zsh" }, -- treate sh & zsh as Bash, replacement of the autocmd below
      settings = { bashls_settings },
    })
  end
  -- vim.api.nvim_create_autocmd("FileType", {
  --   pattern = "sh",
  --   callback = function()
  --     vim.lsp.start({
  --       name = "bash-language-server",
  --       cmd = { "bash-language-server", "start" },
  --     })
  --   end,
  -- })
end

local shells = {}
local bash_treesitter = {}
local bashls_mason = {}
local shells_conform = {}
if shells_opts.enable then
  shells = {
    client_check(),
  }

  if shells_opts.ts_bash then
    bash_treesitter = {
      "nvim-treesitter/nvim-treesitter",
      opts = function(_, opts)
        if type(opts.ensure_installed) == "table" then
          vim.list_extend(opts.ensure_installed, { "bash" })
        end
      end,
    }
  end

  if shells_opts.mason_bash then
    bashls_mason = {
      {
        "mason.nvim",
        opts = function(_, opts)
          opts.ensure_installed = opts.ensure_installed or {}
          vim.list_extend(opts.ensure_installed, { "bash-language-server", "shellcheck", "shfmt" })
        end,
      },
    }
  end

  if shells_opts.conform_shells then
    shells_conform = {
      "stevearc/conform.nvim",
      opts = {
        formatters_by_ft = {
          fish = { "fish_indent" },
          sh = { "shfmt" },
          zsh = { "shfmt" },
          bash = { "shfmt" },
        },
      },
    }
  end
end

return {
  bashls_mason,
  shells,
  bash_treesitter,
  shells_conform,
}
