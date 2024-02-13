local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (todo_comments.lua)", vim.log.levels.WARN)
  return
end

local todo_opts = settings.editor_plugins.todo_comments
local todo_comments = {}

local icons_status, icons = pcall(require, "icons")
if not icons_status then
  vim.notify("[icons] failed to load within (todo_comments)", vim.log.levels.WARN)
  return
end

local error_red = "#F44747"
local warning_orange = "#ff8800"
local info_yellow = "#FFCC66"
local hint_blue = "#4FC1FF"
local perf_purple = "#7C3AED"
-- local note_green = '#10B981'

if todo_opts.enable then
  todo_comments = {
    event = todo_opts.event,
    cmd = todo_opts.cmd,
    keys = todo_opts.keys,
    "folke/todo-comments.nvim",
    opts = {
      signs = true, -- show icons in the signs column
      sign_priority = 8, -- sign priority
      keywords = {
        FIX = {
          icon = icons.ui.Bug, -- icon used for the sign, and in search results
          color = error_red, -- can be a hex color, or a named color (see below)
          alt = {
            "FIXME",
            "FIXES",
            "BUG",
            "BUGS",
            "FIXIT",
            "ISSUE",
            "ISSUES",
          }, -- a set of other keywords that all map to this FIX keywords
          -- signs = false, -- configure signs for some keywords individually
        },
        TODO = {
          icon = icons.ui.Check,
          color = hint_blue,
          alt = { "TIP", "TIPS" },
        },
        HACK = { icon = icons.ui.Fire, color = warning_orange },
        WARN = {
          icon = icons.diagnostics.Warn,
          color = warning_orange,
          alt = { "WARNING", "CAREFULL", "WATCHOUT" },
        },
        PERF = {
          icon = icons.ui.Dashboard,
          color = perf_purple,
          alt = { "PERFORMANCE", "OPTIMIZE", "INHANCE" },
        },
        HINT = {
          icon = icons.diagnostics.Hint,
          color = hint_blue,
          alt = { "HINTS" },
        },
        NOTE = {
          icon = icons.ui.Note,
          color = info_yellow,
          alt = { "NOTES", "INFO", "INFOS" },
        },
        gui_style = {
          fg = "NONE", -- The gui style to use for the fg highlight group.
          bg = "BOLD", -- The gui style to use for the bg highlight group.
        },
        highlight = {
          multiline = true, -- enable multine todo comments
          multiline_context = 3, -- extra lines that will be re-evaluated when changing a line
          before = "", -- "fg" or "bg" or empty
          keyword = "wide", -- "fg", "bg", "wide" or empty. (wide is the same as bg, but will also highlight surrounding characters)
          after = "fg", -- "fg" or "bg" or empty
          pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlightng (vim regex)
          comments_only = true, -- uses treesitter to match keywords in comments only
          max_line_len = 400, -- ignore lines longer than this
          exclude = {}, -- list of file types to exclude highlighting
        },
        search = {
          command = "rg",
          args = {
            "--color=always",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
          },
          -- regex that will be used to match keywords.
          -- don't replace the (KEYWORDS) placeholder
          pattern = [[\b(KEYWORDS):]], -- ripgrep regex
          -- pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
        },
      },
    },
  }
end
return todo_comments
