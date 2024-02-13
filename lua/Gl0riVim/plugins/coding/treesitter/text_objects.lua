local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (treesitter/text_objects.lua)", vim.log.levels.WARN)
  return
end

local treesitter_text_objects = {}
local treesitter_RRethy_text_objects = {}

if settings.coding_plugins.treesitter.extensions.text_objects.enable then
  treesitter_text_objects = {
    {
      "nvim-treesitter/nvim-treesitter-textobjects",
      dependencies = { "nvim-treesitter/nvim-treesitter" },
      event = settings.coding_plugins.treesitter.extensions.text_objects.event,
      config = function()
        -- When in diff mode, we want to use the default
        -- vim text objects c & C instead of the treesitter ones.
        local move = require("nvim-treesitter.textobjects.move") ---@type table<string,fun(...)>
        local configs = require("nvim-treesitter.configs")
        for name, fn in pairs(move) do
          if name:find("goto") == 1 then
            move[name] = function(q, ...)
              if vim.wo.diff then
                local config = configs.get_module("textobjects.move")[name] ---@type table<string,string>
                for key, query in pairs(config or {}) do
                  if q == query and key:find("[%]%[][cC]") then
                    vim.cmd("normal! " .. key)
                    return
                  end
                end
              end
              return fn(q, ...)
            end
          end
        end
      end,
    },
  }
end

if settings.coding_plugins.treesitter.extensions.RRethy_text_objects.enable then
  treesitter_RRethy_text_objects = {
    event = settings.coding_plugins.treesitter.extensions.RRethy_text_objects.event,
    "RRethy/nvim-treesitter-textsubjects",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
  }
end

return {
  treesitter_text_objects,
  treesitter_RRethy_text_objects,
}
