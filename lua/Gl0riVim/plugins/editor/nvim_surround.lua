local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (nvim_surround.lua)", vim.log.levels.WARN)
  return
end

local surround_opts = settings.editor_plugins.nvim_surround

local nvim_surround = {}

if surround_opts.enable then
  nvim_surround = {
    event = surround_opts.event,
    "kylechui/nvim-surround",
    opts = {
      keymaps = {
        visual = surround_opts.keymaps.add_surround,
        delete = surround_opts.keymaps.delete_surrond,
        change = surround_opts.keymaps.change_surround,
      },
    },
  }
end

return nvim_surround
