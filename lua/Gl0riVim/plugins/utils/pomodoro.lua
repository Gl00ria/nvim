local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (pomodoro.lua)", vim.log.levels.WARN)
  return
end

local nomodoro = {}

local nomo_opts = settings.utils_plugins.pomodoro.nomodoro

if nomo_opts.enable then
  nomodoro = {
    "dbinagi/nomodoro",
    cmd = nomo_opts.cmd,
    keys = nomo_opts.keys,
    init = function()
      if nomo_opts.on_startup then
        vim.api.nvim_create_autocmd({ "VimEnter" }, {
          callback = function()
            vim.cmd("NomoWork")
          end,
        })
      end
    end,
    opts = {
      work_time = nomo_opts.work_time,
      break_time = nomo_opts.break_time,
      menu_available = true,
      texts = {
        on_break_complete = "TIME IS UP!",
        on_work_complete = "TIME IS UP!",
        status_icon = "羽",
        timer_format = "!%0M:%0S", -- To include hours: '!%0H:%0M:%0S'
      },
      on_work_complete = function() end,
      on_break_complete = function() end,
    },
  }
end

return nomodoro
