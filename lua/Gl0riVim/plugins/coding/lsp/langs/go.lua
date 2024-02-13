local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (go.lua)", vim.log.levels.WARN)
  return
end

local go_opts = settings.langs_control.go

local go = {}
local treesitter_go = {}
local neotest_go = {}
local none_ls_go = {}
local conform_go = {}

if go_opts.enable then
  go = {
    {
      "mason.nvim",
      opts = function(_, opts)
        opts.ensure_installed = opts.ensure_installed or {}
        vim.list_extend(opts.ensure_installed, { "gomodifytags", "impl", "goimports", "gofumpt", "delve" })
      end,
    },
    {
      "neovim/nvim-lspconfig",
      opts = {
        servers = {
          gopls = {
            keys = { go_opts.keys },
            settings = {
              gopls = {
                gofumpt = true,
                codelenses = {
                  gc_details = false,
                  generate = true,
                  regenerate_cgo = true,
                  run_govulncheck = true,
                  test = true,
                  tidy = true,
                  upgrade_dependency = true,
                  vendor = true,
                },
                hints = {
                  assignVariableTypes = true,
                  compositeLiteralFields = true,
                  compositeLiteralTypes = true,
                  constantValues = true,
                  functionTypeParameters = true,
                  parameterNames = true,
                  rangeVariableTypes = true,
                },
                analyses = {
                  fieldalignment = true,
                  nilness = true,
                  unusedparams = true,
                  unusedwrite = true,
                  useany = true,
                },
                usePlaceholders = true,
                completeUnimported = true,
                staticcheck = true,
                directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
                semanticTokens = true,
              },
            },
          },
        },
      },
    },
  }
  if go_opts.ts_go then
    treesitter_go = {
      "nvim-treesitter/nvim-treesitter",
      opts = function(_, opts)
        vim.list_extend(opts.ensure_installed, {
          "go",
          "gomod",
          "gowork",
          "gosum",
        })
      end,
    }
  end

  if go_opts.neotest_go then
    neotest_go = {
      "nvim-neotest/neotest",
      dependencies = {
        "nvim-neotest/neotest-go",
      },
      opts = {
        adapters = {
          ["neotest-go"] = {
            -- Here we can set options for neotest-go, e.g.
            -- args = { "-tags=integration" }
          },
        },
      },
    }
  end

  if go_opts.nonels_go then
    none_ls_go = {
      "nvimtools/none-ls.nvim",
      optional = true,
      opts = function(_, opts)
        local nls = require("null-ls")
        opts.sources = vim.list_extend(opts.sources or {}, {
          nls.builtins.code_actions.gomodifytags,
          nls.builtins.code_actions.impl,
          nls.builtins.formatting.goimports,
          nls.builtins.formatting.gofumpt,
        })
      end,
    }
  end

  if go_opts.conform_go then
    conform_go = {
      "stevearc/conform.nvim",
      opts = {
        formatters_by_ft = {
          go = { "goimports", "gofumpt" },
        },
      },
    }
  end
end

return {
  go,
  treesitter_go,
  neotest_go,
  none_ls_go,
  conform_go,
}
