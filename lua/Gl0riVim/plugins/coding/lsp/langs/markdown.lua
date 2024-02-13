local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (markdown.lua)", vim.log.levels.WARN)
  return
end

local lspconfig_status, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status then
  vim.notify("[lspconfig] failed to load within (langs/markdown.lua)", vim.log.levels.WARN)
  return
end

local markdown_opts = settings.langs_control.markdwon

local markdown = {}
local markdown_conform = {}
local markdown_treesitter = {}

if markdown_opts.enable then
  markdown = {
    {
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      config = function(_, opts)
        local mason_tool_status, mason_tool = pcall(require, "mason-tool-installer")
        if not mason_tool_status then
          vim.notify("[Mason_tool] failed to load within (langs/markdown)", vim.log.levels.WARN)
          return
        end

        local conf = vim.tbl_deep_extend("keep", opts, {
          ensure_installed = { "markdownlint", "marksman" },
        })
        mason_tool.setup(conf)
      end,
    },

    lspconfig.marksman.setup({}),
  }

  if markdown_opts.conform_markdown then
    markdown_conform = {
      "stevearc/conform.nvim",
      opts = {
        formatters_by_ft = {
          ["markdown"] = { "prettier" },
        },
      },
    }
  end

  if markdown_opts.ts_markdwon then
    markdown_treesitter = {
      "nvim-treesitter/nvim-treesitter",
      opts = function(_, opts)
        if type(opts.ensure_installed) == "table" then
          vim.list_extend(opts.ensure_installed, {
            "markdown",
            "markdown_inline",
          })
        end
      end,
    }
  end
end

return {
  markdown,
  markdown_conform,
  markdown_treesitter,
}
