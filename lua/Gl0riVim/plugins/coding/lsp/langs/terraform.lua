local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (terraform.lua)", vim.log.levels.WARN)
  return
end

local terraform_opts = settings.langs_control.terraform

local terraform = {}
local treesitter_terraform = {}
local nonels_terraform = {}
local nvim_lint_terraform = {}
local conform_terraform = {}

if terraform_opts.enable then
  terraform = {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        terraformls = {},
      },
    },
  }

  if terraform_opts.ts_terraform then
    treesitter_terraform = {
      "nvim-treesitter/nvim-treesitter",
      opts = function(_, opts)
        if type(opts.ensure_installed) == "table" then
          vim.list_extend(opts.ensure_installed, {
            "terraform",
            "hcl",
          })
        end
      end,
    }
  end

  if terraform_opts.nonels_terraform then
    nonels_terraform = {
      "nvimtools/none-ls.nvim",
      optional = true,
      opts = function(_, opts)
        local null_ls = require("null-ls")
        opts.sources = vim.list_extend(opts.sources or {}, {
          null_ls.builtins.formatting.terraform_fmt,
          null_ls.builtins.diagnostics.terraform_validate,
        })
      end,
    }
  end

  if terraform_opts.lint_terraform then
    nvim_lint_terraform = {
      "mfussenegger/nvim-lint",
      optional = true,
      opts = {
        linters_by_ft = {
          terraform = { "terraform_validate" },
          tf = { "terraform_validate" },
        },
      },
    }
  end

  if terraform_opts.conform_terraform then
    conform_terraform = {
      "stevearc/conform.nvim",
      opts = {
        formatters_by_ft = {
          terraform = { "terraform_fmt" },
          tf = { "terraform_fmt" },
          ["terraform-vars"] = { "terraform_fmt" },
        },
      },
    }
  end
end

return {
  terraform,
  treesitter_terraform,
  nonels_terraform,
  nvim_lint_terraform,
  conform_terraform,
}
