local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (track.lua)", vim.log.levels.WARN)
  return
end

local track_opts = settings.utils_plugins.track
local track = {}

if track_opts.enable then
  track = {
    "dharmx/track.nvim",
    keys = track_opts.keys,
    cmd = track_opts.cmd,
    opts = {
      save_path = track_opts.save_path,
      root_path = track_opts.root_path,
      disable_history = track_opts.disable_history,
      maximum_history = track_opts.maximum_history,
      border = track_opts.border,
      width = track_opts.width,
      height = track_opts.height,
      title_pos = track_opts.title_pos,
      exclude = track_opts.exclude,
      pickers = {
        views = {
          attach_mappings = function(_, map)
            local actions = require("telescope.actions") -- telescope builtin
            map("n", track_opts.action_keys.close, actions.close)
            map("n", track_opts.action_keys.select_all, actions.select_all)

            local track_actions = require("telescope._extensions.track.actions") -- track.nvim builtin
            map("n", track_opts.action_keys.delete_all, actions.select_all + track_actions.delete_view)
            map("n", track_opts.action_keys.delete_current, track_actions.delete_view)
            map("n", track_opts.action_keys.change_mark_view, track_actions.change_mark_view)
            map("n", track_opts.action_keys.delete_buffer, track_actions.delete_buffer)
            map("n", track_opts.action_keys.move_view_next, track_actions.move_view_next)
            map("n", track_opts.action_keys.move_view_previous, track_actions.move_view_previous)
            return true -- compulsory
          end,
        },
      },
    },
  }
end

return track
