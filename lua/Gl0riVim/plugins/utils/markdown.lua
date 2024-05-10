local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (markdown.lua)", vim.log.levels.WARN)
  return
end

local markdown_opts = settings.langs_control.markdwon

local md_preview = {}
local md_headelines = {}

local better_hl_opts = settings.langs_control.markdwon.md_better_headlines
local md_better_hl = {}

if markdown_opts.markdown_preview.enable then
  md_preview = {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    keys = markdown_opts.markdown_preview.keys,
    config = function()
      vim.cmd([[do FileType]])
    end,
  }
end

if markdown_opts.markdown_headlines then
  md_headelines = {
    "lukas-reineke/headlines.nvim",
    ft = { "markdown", "org", "norg" },
    config = function()
      local status_ok, headlines = pcall(require, "headlines")
      if not status_ok then
        vim.notify("Plugin [headlines] failed to load", vim.log.levels.WARN)
        return
      end

      vim.cmd([[highlight Headline1 guibg=#1e2718]])
      vim.cmd([[highlight Headline2 guibg=#21262d]])
      vim.cmd([[highlight CodeBlock guibg=#1c1c1c]])
      vim.cmd([[highlight Dash guibg=#D19A66 gui=bold]])

      headlines.setup({
        markdown = {
          headline_highlights = { "Headline1", "Headline2" },
        },

        norg = {
          headline_highlights = { "Headline1", "Headline2" },
        },

        org = {
          headline_highlights = { "Headline1", "Headline2" },
        },
      })
    end,
  }
end

if better_hl_opts.enable then
  md_better_hl = {
    "MeanderingProgrammer/markdown.nvim",
    ft = better_hl_opts.ft,
    name = "render-markdown", -- Only needed if you have another plugin named markdown.nvim
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {
      start_enabled = better_hl_opts.enable,
      file_types = better_hl_opts.file_types,
      headings = better_hl_opts.headings,
      dash = better_hl_opts.dash,
      bullets = better_hl_opts.bullets,
      quote = better_hl_opts.quote,
      checkbox = {
        unchecked = better_hl_opts.unchecked,
        checked = better_hl_opts.checked,
      },
      highlights = {
        heading = {
          -- Background of heading line
          backgrounds = { "DiffAdd", "DiffChange", "DiffDelete" },
          -- Foreground of heading character only
          foregrounds = {
            "markdownH1",
            "markdownH2",
            "markdownH3",
            "markdownH4",
            "markdownH5",
            "markdownH6",
          },
        },
      },
    },
  }
end

return { md_preview, md_headelines, md_better_hl }
