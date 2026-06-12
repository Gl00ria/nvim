-- https://www.reddit.com/r/neovim/comments/18a77w2/good_lintingformatting_configuration_for_php_in/
-- https://github.com/PHP-CS-Fixer/PHP-CS-Fixer
return {
  {
    "stevearc/conform.nvim",
    lazy = true,
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      formatters_by_ft = {
        php = { "php-cs-fixer" },
      },
      formatters = {
        ["php-cs-fixer"] = {
          command = "php-cs-fixer",
          args = {
            "fix",
            "--rules=@PSR12", -- Formatting preset. Other presets are available, see the php-cs-fixer docs.
            "$FILENAME",
          },
          stdin = false,
        },
      },
      notify_on_error = true,
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        intelephense = {
          diagnostics = {
            exclude = {
              ["*.php"] = { "P1132" },
            },
          },
        },
      },
    },
  },
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {},
    },
  },
  -- {
  --   "adalessa/laravel.nvim",
  --   dependencies = {
  --     "MunifTanjim/nui.nvim",
  --     "nvim-lua/plenary.nvim",
  --     "nvim-neotest/nvim-nio",
  --   },
  --   ft = { "php", "blade" },
  --   event = { "BufEnter composer.json" },
  --   keys = {
  --     {
  --       "<leader>ll",
  --       function()
  --         Laravel.pickers.laravel()
  --       end,
  --       desc = "Laravel: Picker",
  --     },
  --     {
  --       "<leader>la",
  --       function()
  --         Laravel.pickers.artisan()
  --       end,
  --       desc = "Laravel: Artisan Picker",
  --     },
  --     {
  --       "<leader>lr",
  --       function()
  --         Laravel.pickers.routes()
  --       end,
  --       desc = "Laravel: Routes Picker",
  --     },
  --     {
  --       "<leader>lm",
  --       function()
  --         Laravel.pickers.make()
  --       end,
  --       desc = "Laravel: Make Picker",
  --     },
  --     {
  --       "<leader>lc",
  --       function()
  --         Laravel.pickers.commands()
  --       end,
  --       desc = "Laravel: Custom Commands Picker",
  --     },
  --     {
  --       "<leader>lo",
  --       function()
  --         Laravel.pickers.resources()
  --       end,
  --       desc = "Laravel: Resources Picker",
  --     },
  --     {
  --       "<leader>lh",
  --       function()
  --         Laravel.run("artisan docs")
  --       end,
  --       desc = "Laravel: Documentation",
  --     },
  --     {
  --       "<leader>lt",
  --       function()
  --         Laravel.commands.run("actions")
  --       end,
  --       desc = "Laravel: Code Actions",
  --     },
  --     {
  --       "<leader>lu",
  --       function()
  --         Laravel.commands.run("hub")
  --       end,
  --       desc = "Laravel: Artisan Hub",
  --     },
  --     {
  --       "<leader>lp",
  --       function()
  --         Laravel.commands.run("command_center")
  --       end,
  --       desc = "Laravel: Command Center",
  --     },
  --     {
  --       "<c-g>",
  --       function()
  --         Laravel.commands.run("view:finder")
  --       end,
  --       desc = "Laravel: View Finder",
  --     },
  --     {
  --       "gf",
  --       function()
  --         if Laravel.app("gf").cursorOnResource() then
  --           return "<cmd>lua Laravel.commands.run('gf')<cr>"
  --         end
  --         return "gf"
  --       end,
  --       expr = true,
  --       noremap = true,
  --       desc = "Laravel: Go to resource",
  --     },
  --   },
  --   opts = {
  --     features = {
  --       pickers = {
  --         provider = "telescope", -- telescope | fzf-lua | snacks | ui.select
  --       },
  --     },
  --   },
  -- },
}
