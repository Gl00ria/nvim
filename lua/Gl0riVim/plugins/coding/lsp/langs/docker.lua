local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (docker.lua)", vim.log.levels.WARN)
  return
end

local docker = {}
local docker_treesitter = {}
local docker_none_ls = {}
local docker_nvim_lint = {}

local docker_opts = settings.langs_control.docker

if docker_opts.enable then
  docker = {
    {
      "mason.nvim",
      opts = function(_, opts)
        opts.ensure_installed = opts.ensure_installed or {}
        vim.list_extend(opts.ensure_installed, { "hadolint" })
      end,
    },
    {
      "neovim/nvim-lspconfig",
      opts = {
        servers = {
          dockerls = {},
          docker_compose_language_service = {},
        },
      },
    },
  }

  if docker_opts.ts_docker then
    docker_treesitter = {
      "nvim-treesitter/nvim-treesitter",
      opts = function(_, opts)
        if type(opts.ensure_installed) == "table" then
          vim.list_extend(opts.ensure_installed, { "dockerfile" })
        end
      end,
    }
  end

  if docker_opts.nonels_docer then
    docker_none_ls = {
      "nvimtools/none-ls.nvim",
      optional = true,
      opts = function(_, opts)
        local nls = require("null-ls")
        opts.sources = vim.list_extend(opts.sources or {}, {
          nls.builtins.diagnostics.hadolint,
        })
      end,
    }
  end

  if docker_opts.lint_docker then
    docker_nvim_lint = {
      "mfussenegger/nvim-lint",
      optional = true,
      opts = {
        linters_by_ft = {
          dockerfile = { "hadolint" },
        },
      },
    }
  end
end

return {
  docker,
  docker_treesitter,
  docker_none_ls,
  docker_nvim_lint,
}
