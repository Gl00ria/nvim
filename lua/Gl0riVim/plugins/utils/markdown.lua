local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (markdown.lua)", vim.log.levels.WARN)
  return
end

local markdown_opts = settings.langs_control.markdwon

local md_preview = {}
local md_headelines = {}

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

return { md_preview, md_headelines }
