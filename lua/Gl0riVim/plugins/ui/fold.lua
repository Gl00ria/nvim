local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (fold.lua)", vim.log.levels.WARN)
  return
end

local fold_opts = settings.ui_plugins.foldding

local pretty_fold = {}

if fold_opts.enable then
  pretty_fold = {
    "anuvyklack/pretty-fold.nvim",
    dependencies = {
      "anuvyklack/keymap-amend.nvim",
      {
        "anuvyklack/fold-preview.nvim",
        opts = {
          auto = 1, -- integer | false
          -- default_keybindings = true,
          border = fold_opts.preview_border,
        },
      },
    },
    keys = fold_opts.keys,
    opts = {
      -- fill_char = '•',
      fill_char = "━",
      sections = {
        left = {
          "━ ",
          function()
            return string.rep("*", vim.v.foldlevel)
          end,
          " ━┫",
          "content",
          "┣",
        },
        right = {
          "┫ ",
          "number_of_folded_lines",
          ": ",
          "percentage",
          " ┣━━",
        },
      },
      ft_ignore = { "neorg" },

      -- Configuration for C++ to get nice foldtext for Doxygen comments
      process_comment_signs = false,
      comment_signs = {
        "/**", -- C++ Doxygen comments
      },
      stop_words = {
        "%*%s*@brief%s*",
      },
    },
  }
end

return pretty_fold
