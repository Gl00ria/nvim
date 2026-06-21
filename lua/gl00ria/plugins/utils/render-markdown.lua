vim.pack.add {
  'https://github.com/nvim-treesitter/nvim-treesitter',
  'https://github.com/MeanderingProgrammer/render-markdown.nvim',
}

local ok, render_md = pcall(require, 'render-markdown')
if ok then
  render_md.setup {
    anti_conceal = { enabled = true },
    render_modes = { 'n', 'c', 't' },
    callout = {
      note = {
        raw = '[!NOTE]',
        rendered = '󰋽 Note',
        highlight = 'RenderMarkdownInfo',
        category = 'github',
      },
      tip = {
        raw = '[!TIP]',
        rendered = '󰌶 Tip',
        highlight = 'RenderMarkdownSuccess',
        category = 'github',
      },
      important = {
        raw = '[!IMPORTANT]',
        rendered = '󰅾 Important',
        highlight = 'RenderMarkdownHint',
        category = 'github',
      },
      warning = {
        raw = '[!WARNING]',
        rendered = '󰀪 Warning',
        highlight = 'RenderMarkdownWarn',
        category = 'github',
      },
      caution = {
        raw = '[!CAUTION]',
        rendered = '󰳦 Caution',
        highlight = 'RenderMarkdownError',
        category = 'github',
      },
      abstract = {
        raw = '[!ABSTRACT]',
        rendered = '󰨸 Abstract',
        highlight = 'RenderMarkdownInfo',
        category = 'obsidian',
      },
      summary = {
        raw = '[!SUMMARY]',
        rendered = '󰨸 Summary',
        highlight = 'RenderMarkdownInfo',
        category = 'obsidian',
      },
      here = {
        raw = '[!HERE]',
        rendered = ' Here',
        highlight = 'RenderMarkdownInfo',
        category = 'obsidian',
      },
      tldr = {
        raw = '[!TLDR]',
        rendered = '󰨸 Tldr',
        highlight = 'RenderMarkdownInfo',
        category = 'obsidian',
      },
      info = {
        raw = '[!INFO]',
        rendered = '󰋽 Info',
        highlight = 'RenderMarkdownInfo',
        category = 'obsidian',
      },
      half_complted = {
        raw = '[!HALF]',
        rendered = '󱦒 Half complted',
        highlight = 'RenderMarkdownInfo',
        category = 'obsidian',
      },
      todo = {
        raw = '[!TODO]',
        rendered = '󰗡 Todo',
        highlight = 'RenderMarkdownInfo',
        category = 'obsidian',
      },
      hint = {
        raw = '[!HINT]',
        rendered = '󰌶 Hint',
        highlight = 'RenderMarkdownSuccess',
        category = 'obsidian',
      },
      success = {
        raw = '[!SUCCESS]',
        rendered = '󰄬 Success',
        highlight = 'RenderMarkdownSuccess',
        category = 'obsidian',
      },
      check = {
        raw = '[!CHECK]',
        rendered = '󰄬 Check',
        highlight = 'RenderMarkdownSuccess',
        category = 'obsidian',
      },
      done = {
        raw = '[!DONE]',
        rendered = '󰄬 Done',
        highlight = 'RenderMarkdownSuccess',
        category = 'obsidian',
      },
      completed = {
        raw = '[!COMPLETED]',
        rendered = '󰄬 COMPLETED',
        highlight = 'RenderMarkdownSuccess',
        category = 'obsidian',
      },
      question = {
        raw = '[!QUESTION]',
        rendered = '󰘥 Question',
        highlight = 'RenderMarkdownWarn',
        category = 'obsidian',
      },
      help = {
        raw = '[!HELP]',
        rendered = '󰘥 Help',
        highlight = 'RenderMarkdownWarn',
        category = 'obsidian',
      },
      faq = {
        raw = '[!FAQ]',
        rendered = '󰘥 Faq',
        highlight = 'RenderMarkdownWarn',
        category = 'obsidian',
      },
      attention = {
        raw = '[!ATTENTION]',
        rendered = '󰀪 Attention',
        highlight = 'RenderMarkdownWarn',
        category = 'obsidian',
      },
      failure = {
        raw = '[!FAILURE]',
        rendered = '󰅖 Failure',
        highlight = 'RenderMarkdownError',
        category = 'obsidian',
      },
      fail = {
        raw = '[!FAIL]',
        rendered = '󰅖 Fail',
        highlight = 'RenderMarkdownError',
        category = 'obsidian',
      },
      missing = {
        raw = '[!MISSING]',
        rendered = '󰅖 Missing',
        highlight = 'RenderMarkdownError',
        category = 'obsidian',
      },
      danger = {
        raw = '[!DANGER]',
        rendered = '󱐌 Danger',
        highlight = 'RenderMarkdownError',
        category = 'obsidian',
      },
      error = {
        raw = '[!ERROR]',
        rendered = '󱐌 Error',
        highlight = 'RenderMarkdownError',
        category = 'obsidian',
      },
      bug = {
        raw = '[!BUG]',
        rendered = '󰨰 Bug',
        highlight = 'RenderMarkdownError',
        category = 'obsidian',
      },
      example = {
        raw = '[!EXAMPLE]',
        rendered = '󰉹 Example',
        highlight = 'RenderMarkdownHint',
        category = 'obsidian',
      },
      quote = {
        raw = '[!QUOTE]',
        rendered = '󱆨 Quote',
        highlight = 'RenderMarkdownQuote',
        category = 'obsidian',
      },
      cite = {
        raw = '[!CITE]',
        rendered = '󱆨 Cite',
        highlight = 'RenderMarkdownQuote',
        category = 'obsidian',
      },
    },
    code = {
      sign = true,
      width = 'block',
      left_pad = 2,
      right_pad = 4,
    },

    heading = {
      position = 'inline',
      -- icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
    },
    checkbox = {
      enabled = true,
      render_modes = true,
      unchecked = { icon = '✘ ' },
      checked = {
        icon = '✔ ',
        -- scope_highlight = "@markup.strikethrough", -- cross the done once
      },
      -- custom = { todo = { rendered = "◯ " } },
      custom = {
        important_done = {
          raw = '[~~]',
          rendered = '󰓎 DONE',
          highlight = 'RenderMarkdownSuccess',
        },
        important_todo = {
          raw = '[~]',
          rendered = '󰓎 TODO',
          highlight = 'DiagnosticWarn',
        },
      },
    },
  }
else
  vim.notify('Failed to load plugin [render-markdown@render-markdown.lua]', vim.log.levels.ERROR)
end
