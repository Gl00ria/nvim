-- https://github.com/olimorris/codecompanion.nvim/blob/main/lua/codecompanion/config.lua
return {
  event = "VeryLazy",
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    {
      "MeanderingProgrammer/render-markdown.nvim",
      ft = { "markdown", "codecompanion" },
    },
    {
      "saghen/blink.cmp",
      opts = {
        sources = {
          per_filetype = {
            codecompanion = { "codecompanion" },
          },
        },
      },
    },
  },
  keys = {
    { "<leader>ac", "<cmd>CodeCompanionChat Toggle<cr>", mode = { "n", "v" }, desc = "AI Chat" },
    { "<leader>aa", "<cmd>CodeCompanionActions<cr>", mode = { "n", "v" }, desc = "AI Actions" },
    { "<leader>ap", "<cmd>CodeCompanion<cr>", desc = "AI Quick Prompt" },
  },
  opts = {
    -- https://codecompanion.olimorris.dev/configuration/adapters.html
    adapters = {
      -- show_model_choices = true,
      ollama = function()
        return require("codecompanion.adapters").extend("ollama", {
          schema = {
            -- model = { default = "mistral:7b" }, -- tools
            -- model = { default = "llama3.1:8b" }, --  tools
            -- model = { default = "llama3.2:3b" }, --  tools
            -- model = { default = "phi3:3.8b" }, --  code
            -- model = { default = "qwen2.5-coder:7b" }, -- code
            -- model = { default = "codellama:7b" }, --  code
            -- model = { default = "granite3.1-moe:3b" }, --  tools | code
            -- model = { default = "granite3.3:8b" }, --  tools | code
            -- model = { default = "granite-code:8b" },-- TODO:  code
            -- model = { default = "codegemma:7b" },-- TODO:  code
            -- model = { default = "deepseek-coder:6.7b" },-- TODO:  code
            -- model = { default = "qwen3:8b" }, --  tools | thinking | code
            -- model = { default = "gpt-oss:20b" }, -- tools | thinking
            -- model = { default = "deepseek-r1:8b" }, -- tools | thinking
            env = {
              url = "http://localhost:11434",
            },
            -- num_ctx = { default = 16384 },
            -- num_predict = { default = -1 },
          },
          headers = {
            ["Content-Type"] = "application/json",
            -- ["Authorization"] = "Bearer ${api_key}",
          },
          -- parameters = {
          --   sync = true,
          -- },
        })
      end,
    },
    strategies = {
      chat = {
        adapter = "ollama",
      },
      inline = { adapter = "ollama" },
      agent = { adapter = "ollama" },
    },
    memory = {
      opts = {
        chat = {
          enabled = true,
        },
      },
    },
    display = {
      auto_scroll = false,
      action_palette = {
        width = 95,
        height = 10,
        prompt = "Prompt", -- Prompt used for interactive LLM calls
        provider = "fzf_lua", -- snacks|fzf_lua|default
        opts = {
          show_default_actions = true, -- Show the default actions in the action palette?
          show_default_prompt_library = true, -- Show the default prompt library in the action palette?
          title = "CodeCompanion actions", -- The title of the action palette
        },
      },
    },
    -- NOTE: The log_level is in `opts.opts`
    opts = {
      log_level = "DEBUG", -- or "TRACE"
    },
  },
}
