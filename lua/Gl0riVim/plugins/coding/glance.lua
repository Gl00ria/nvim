local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (glance.lua)", vim.log.levels.WARN)
  return
end

local glance_opts = settings.coding_plugins.glance

local glance = {}

local filter = require("Gl0riVim.plugins.00_config.lsp.utils.filter").filter
local filterReactDTS = require("Gl0riVim.plugins.00_config.lsp.utils.filterreactDTS").filterReactDTS

if glance_opts.enable then
  glance = {
    "dnlhc/glance.nvim",
    cmd = glance_opts.cmd,
    keys = glance_opts.keys,
    opts = {
      hooks = {
        before_open = function(results, open, jump, method)
          if #results == 1 then
            jump(results[1]) -- argument is optional
          elseif method == "definitions" then
            results = filter(results, filterReactDTS)
            open(results)
          else
            open(results)
          end
        end,
      },
    },
  }
end

return glance
