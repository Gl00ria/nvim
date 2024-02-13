local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (tmux_navigator.lua)", vim.log.levels.WARN)
  return
end

local tmux_opts = settings.utils_plugins.tmux

local tmux_navigator = {}
local tmux_sessionizer = {}

if tmux_opts.tmux_navigator.enable then
  tmux_navigator = {
    {
      "christoomey/vim-tmux-navigator",
      event = tmux_opts.tmux_navigator.event,
      cmd = tmux_opts.tmux_navigator.cmd,
      keys = tmux_opts.tmux_navigator.keys,
    },
  }
end

if tmux_opts.tmux_sessionizer.enable then
  tmux_sessionizer = {
    {
      "sanathks/workspace.nvim",
      dependencies = { "nvim-telescope/telescope.nvim" },
      keys = tmux_opts.tmux_sessionizer.keys,
      config = function()
        local sessionizer_status, t_workspace = pcall(require, "workspace")
        if not sessionizer_status then
          vim.notify("Plugin [workspace] failed to load within (tmux.lua)", vim.log.levels.WARN)
          return
        end

        t_workspace.setup({
          workspaces = tmux_opts.tmux_sessionizer.workspaces,
        })
        vim.keymap.set("n", "<leader>Ts", t_workspace.tmux_sessions)
      end,
    },
  }
end

return { tmux_navigator, tmux_sessionizer }
