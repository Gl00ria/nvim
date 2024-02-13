local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (treesitter.lua)", vim.log.levels.WARN)
  return
end

local treesitter_opts = settings.coding_plugins.treesitter

local treesitter = {}

if treesitter_opts.enable then
  treesitter = {
    {
      "nvim-treesitter/nvim-treesitter",
      event = treesitter_opts.event,
      build = ":TSUpdate",
      init = function(plugin)
        -- Add nvim-treesitter queries to the rtp and it's custom query predicates early
        -- This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
        -- no longer trigger the **nvim-treeitter** module to be loaded in time.
        -- Luckily, the only thins that those plugins need are the custom queries, which we make available
        -- during startup.
        require("lazy.core.loader").add_to_rtp(plugin)
        require("nvim-treesitter.query_predicates")
      end,
      opts = {
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        autopairs = { enable = true },
        rainbow = { enable = true },
        indent = { enable = true },
        ensure_installed = { treesitter_opts.ensure_installed },
        incremental_selection = {
          enable = false,
          keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
            ["aa"] = "@parameter.outer",
            ["ia"] = "@parameter.inner",
          },
          selection_modes = {
            ["@function.outer"] = "V",
            ["@class.outer"] = "V",
          },
        },
        textobjects = {
          move = {
            enable = true,
            goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer" },
            goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer" },
            goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer" },
            goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer" },
          },
        },
        swap = {
          enable = true,
          swap_next = {
            ["]a"] = "@parameter.inner",
          },
          swap_previous = {
            ["[a"] = "@parameter.inner",
          },
        },
      },
      config = function(_, opts)
        if type(opts.ensure_installed) == "table" then
          ---@type table<string, boolean>
          local added = {}
          opts.ensure_installed = vim.tbl_filter(function(lang)
            if added[lang] then
              return false
            end
            added[lang] = true
            return true
          end, opts.ensure_installed)
        end
        require("nvim-treesitter.configs").setup(opts)
      end,
    },
  }
end

return treesitter
