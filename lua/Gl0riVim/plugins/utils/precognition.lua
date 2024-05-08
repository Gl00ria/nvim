local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (precognition.lua)", vim.log.levels.WARN)
  return
end

local precognition_opts = settings.utils_plugins.precognition
local precognition = {}

if precognition_opts.enable then
  precognition = {
    "tris203/precognition.nvim",
    config = {
      startVisible = precognition_opts.startVisible,
      showBlankVirtLine = precognition_opts.showBlankVirtLine,
      hints = {
        Caret = { text = "^", prio = 1 },
        Dollar = { text = "$", prio = 1 },
        w = { text = "w", prio = 10 },
        b = { text = "b", prio = 10 },
        e = { text = "e", prio = 10 },
      },
      gutterHints = {
        --prio is not currentlt used for gutter hints
        G = { text = "G", prio = 1 },
        gg = { text = "gg", prio = 1 },
        PrevParagraph = { text = "{", prio = 1 },
        NextParagraph = { text = "}", prio = 1 },
      },
    },
  }
end
return precognition
