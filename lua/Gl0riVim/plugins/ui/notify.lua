local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (notify.lua)", vim.log.levels.WARN)
  return
end

local notify_opts = settings.ui_plugins.notify

local notify = {}

-- Some colorschemes do not yet support the NotifyBackground highlight group
local notify_bg = "NotifyBackground"
local ok, _ = pcall(vim.api.nvim_get_hl_id_by_name, notify_bg, true)
if not ok then
  notify_bg = "NotifyERRORBody"
  ok, _ = pcall(vim.api.nvim_get_hl_id_by_name, notify_bg, true)
  if not ok then
    notify_bg = "#000000"
  end
end

if notify_opts.enable then
  notify = {
    event = notify_opts.event,
    "rcarriga/nvim-notify",
    keys = notify_opts.keys,
    init = function()
      local banned_messages = {
        "No information available",
        "LSP[tsserver] Inlay Hints request failed. Requires TypeScript 4.4+.",
        "LSP[tsserver] Inlay Hints request failed. File not opened in the editor.",
      }
      local notify_func = function(msg, ...)
        for _, banned in ipairs(banned_messages) do
          if msg == banned then
            return
          end
        end
        return require("notify")(msg, ...)
      end
      -- when noice is not enabled, install notify on VeryLazy
      local util_status, Util = pcall(require, "util")
      if not util_status then
        vim.notify("[Util] failed to load within (notify.lua)", vim.log.levels.WARN)
        return
      end
      if Util.has("noice.nvim") then
        vim.notify = notify_func
      else
        Util.on_very_lazy(function()
          vim.notify = notify_func
        end)
      end
    end,
    opts = {
      background_colour = notify_bg,
      stages = notify_opts.stages,
      timeout = 3000,
      max_height = function()
        return math.floor(vim.o.lines * 0.75)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.75)
      end,
    },
  }
end

return notify
