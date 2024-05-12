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
      after = "nvim-treesitter",
      dependencies = { "nvim-treesitter/nvim-treesitter" },
      event = settings.coding_plugins.treesitter.extensions.text_objects.event,
      config = function()
        local configs = require("nvim-treesitter.configs")
        configs.setup({
          textobjects = {
            select = {
              eanble = true,
              lookahead = true,
              keymaps = {
                ["aa"] = "@parameter.outer",
                ["ia"] = "@parameter.inner",
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner",
                ["ii"] = "@conditional.inner",
                ["ai"] = "@conditional.outer",
                ["il"] = "@loop.inner",
                ["al"] = "@loop.outer",
                ["at"] = "@comment.outer",
              },
            },
            move = {
              enable = true,
              set_jumps = true, -- whether to set jumps in the jumplist
              goto_next_start = {
                ["]f"] = "@function.outer",
                ["]]"] = "@class.outer",
              },
              goto_next_end = {
                ["]F"] = "@function.outer",
                ["]["] = "@class.outer",
              },
              goto_previous_start = {
                ["[f"] = "@function.outer",
                ["[["] = "@class.outer",
              },
              goto_previous_end = {
                ["[F"] = "@function.outer",
                ["[]"] = "@class.outer",
              },
            },
            swap = {
              enable = true,
              swap_next = {
                ["<leader>0"] = "@parameter.inner",
              },
              swap_previous = {
                ["<leader>1"] = "@parameter.inner",
              },
            },
          },
        })
        -- When in diff mode, we want to use the default
        -- vim text objects c & C instead of the treesitter ones.
        local move = require("nvim-treesitter.textobjects.move")
        for name, fn in pairs(move) do
          if name:find("goto") == 1 then
            move[name] = function(q, ...)
              if vim.wo.diff then
                local config = configs.get_module("textobjects.move")[name]
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
    after = "nvim-treesitter",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
  }
end

return {
  treesitter_text_objects,
  treesitter_RRethy_text_objects,
}
