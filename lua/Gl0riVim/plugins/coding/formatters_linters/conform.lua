local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (conform.lua)", vim.log.levels.WARN)
  return
end

local linterConfig = vim.fn.stdpath("config") .. ".linter_configs"

local conform_opts = settings.coding_plugins.conform

local conform = {}

if conform_opts.enable then
  conform = {
    lazy = conform_opts.lazy,
    event = conform_opts.event,
    "stevearc/conform.nvim",
    keys = {
      { conform_opts.keymaps.key, conform_opts.keymaps.cmd, conform_opts.keymaps.desc },
    },
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        -- ["*"] = { "codespell" },
        -- Use the "_" filetype to run formatters on filetypes that don't
        -- have other formatters conf.gured.
        -- ["_"] = { "trim_whitespace" },
      },
      format_on_save = {
        lsp_fallback = true,
        async = false,
        timeout_ms = 10000,
      },
      format_after_save = {
        lsp_fallback = true,
      },
      log_level = vim.log.levels.ERROR,
      -- Conform will notify you when a formatter errors
      notify_on_error = true,

      formatters = {
        injected = { options = { ignore_errors = true } },
        markdownlint = {
          command = "markdownlint",
          stdin = false,
          args = { "--fix", "--config", linterConfig .. "/markdownlint.yaml", "$FILENAME" },
        },
        flake8 = {
          command = "flake8",
          stdin = false,
          args = { "--ignore=E203,E501,E402,F401,F821,W503,W292" },
        },
        beautysh = {
          command = "beautysh",
          stdin = false,
          args = { "--indent-size", "2" },
        },
        shellcheck = {
          command = "shellcheck",
          -- Using `git apply` is the officially recommended way for auto-fixing
          -- https://github.com/koalaman/shellcheck/issues/1220#issuecomment-594811243
          -- arg = "--shell=bash --format=diff '$FILENAME' | git apply",
          arg = "--shell=bash",
          stdin = false,
        },
        codespell = {
          command = "codespell",
          stdin = false,
          args = {
            "$FILENAME",
            "--write-changes",
            "--builtin=rare,clear,informal,code,names,en-GB_to_en-US",
            "--check-hidden", -- conform temp file is hidden
            "--ignore-words",
            linterConfig .. "/codespell-ignore.txt",
          },
          -- don't run on css or bib files
          condition = function(ctx)
            return not (ctx.filename:find("%.css$") or ctx.filename:find("%.bib$"))
          end,
        },
        bibtex_tidy = {
          command = "bibtex-tidy",
          stdin = true,
          args = {
            "--quiet",
            "--tab",
            "--curly",
            "--strip-enclosing-braces",
            "--enclosing-braces=title,journal,booktitle",
            "--numeric",
            "--months",
            "--no-align",
            "--encode-urls",
            "--duplicates",
            "--drop-all-caps",
            "--sort-fields",
            "--remove-empty-fields",
            "--no-wrap",
          },
        },
      },
    },
  }
end

return conform
