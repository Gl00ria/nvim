-- local linter_status, linter = pcall(require, "Gl0riVim.utils.linter")
-- if not linter_status then
--   vim.notify("[linter] failed to load within (formatters.lua)", vim.log.levels.WARN)
--   return
-- end

local settigns_status, settings = pcall(require, "control_center")
if not settigns_status then
  vim.notify("[settings] failed to load within (linter.lua)", vim.log.levels.WARN)
  return
end

local nvim_lint_opts = settings.coding_plugins.nvim_lint

local nvim_linter = {}

if nvim_lint_opts.enable then
  nvim_linter = {
    {
      "mfussenegger/nvim-lint",
      event = nvim_lint_opts.event,
      config = function()
        local linterConfig = vim.fn.stdpath("config") .. ".linter_configs"
        local lint = require("lint")
        local linters = require("lint").linters

        lint.linter_by_ft = {
          lua = { "stylua" },
          css = { "stylelint" },
          markdown = { "markdownlint" },
          yaml = { "yamllint" },
          javascript = { "eslint_d" },
          typescript = { "eslint_d" },
          javascriptreact = { "eslint_d" },
          typescriptreact = { "eslint_d" },
          svelte = { "eslint_d" },
          python = { "pylint" },
          gitcommit = {},
          json = {},
          toml = {},
          text = {},
        }

        -- use for codespell for all except bib and css
        for ft, _ in pairs(lint.linters_by_ft) do
          if ft ~= "bib" and ft ~= "css" then
            table.insert(lint.linters_by_ft[ft], "codespell")
          end
        end

        linters.codespell.args = {
          "--ignore-words",
          linterConfig .. "/codespell-ignore.txt",
          "--builtin=rare,clear,informal,code,names,en-GB_to_en-US",
        }

        linters.shellcheck.args = {
          "--shell=bash", -- force to work with zsh
          "--format=json",
          "-",
        }

        linters.yamllint.args = {
          "--config-file",
          linterConfig .. "/yamllint.yaml",
          "--format=parsable",
          "-",
        }

        linters.markdownlint.args = {
          "--disable=no-trailing-spaces", -- not disabled in config, so it's enabled for formatting
          "--disable=no-multiple-blanks",
          "--config=" .. linterConfig .. "/markdownlint.yaml",
        }

        function LintTriggers()
          vim.api.nvim_create_autocmd({ "BufReadPost", "InsertLeave", "TextChanged", "FocusGained" }, {
            callback = function()
              vim.defer_fn(require("lint").try_lint, 1)
            end,
          })

          -- due to auto-save.nvim, we need the custom event "AutoSaveWritePost"
          -- instead of "BufWritePost" to trigger linting to prevent race conditions
          vim.api.nvim_create_autocmd("User", {
            pattern = "AutoSaveWritePost",
            callback = function()
              require("lint").try_lint()
            end,
          })
          -- run once on start
          require("lint").try_lint()
        end
      end,
    },
  }
end

return nvim_linter
