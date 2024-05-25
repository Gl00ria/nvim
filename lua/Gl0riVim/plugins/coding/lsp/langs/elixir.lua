local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (elixir.lua)", vim.log.levels.WARN)
  return
end

local elixir_opts = settings.langs_control.elixir

local elixir = {}
local treesitter_elixir = {}
local neotest_elixir = {}
local none_ls_elixir = {}
local nvim_lint_elixir = {}

local lspconfig_status, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status then
  vim.notify("[lspconfig] failed to load within (elixir.lua)", vim.log.levels.WARN)
  return
end

if elixir_opts.enable then
  elixir = {
    {
      "mason.nvim",
      opts = function(_, opts)
        opts.ensure_installed = opts.ensure_installed or {}
        vim.list_extend(opts.ensure_installed, { "elixir-ls" })
      end,
    },
    {
      lspconfig.elixirls.setup({
        filetypes = { "elixir", "eelixir", "heex", "surface" },
        cmd = { "elixir-ls", "--studio" },
        single_file_support = true,
      }),
    },
  }

  if elixir_opts.ts_elixir then
    treesitter_elixir = {
      "nvim-treesitter/nvim-treesitter",
      opts = function(_, opts)
        vim.list_extend(opts.ensure_installed, {
          "elixir",
          "heex",
          "eex",
        })
      end,
    }

    if elixir_opts.neotest_elixir then
      neotest_elixir = {
        "nvim-neotest/neotest",
        optional = true,
        dependencies = {
          "jfpedroza/neotest-elixir",
        },
        opts = {
          adapters = {
            ["neotest-elixir"] = {},
          },
        },
      }
    end

    if elixir_opts.nonels_elixir then
      none_ls_elixir = {
        "nvimtools/none-ls.nvim",
        optional = true,
        opts = function(_, opts)
          if vim.fn.executable("credo") == 0 then
            return
          end
          local nls = require("null-ls")
          opts.sources = vim.list_extend(opts.sources or {}, {
            nls.builtins.diagnostics.credo,
          })
        end,
      }
    end

    if elixir_opts.lint_elixir then
      nvim_lint_elixir = {
        "mfussenegger/nvim-lint",
        optional = true,
        opts = function(_, opts)
          if vim.fn.executable("credo") == 0 then
            return
          end
          opts.linters_by_ft = {
            elixir = { "credo" },
          }
        end,
      }
    end
  end
end

return {
  elixir,
  treesitter_elixir,
  neotest_elixir,
  none_ls_elixir,
  nvim_lint_elixir,
}
