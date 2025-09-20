return {
  "yetone/avante.nvim",
  -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  -- ⚠️ must add this setting! ! !
  build = vim.fn.has("win32") ~= 0 and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
    or "make",
  event = "VeryLazy",
  version = false, -- Never set this value to "*"! Never!
  ---@module 'avante'
  ---@type avante.Config
  opts = {
    -- add any opts here
    -- this file can contain specific instructions for your project
    instructions_file = "avante.md",
    provider = "qwen_vllm",
    providers = {
      qwen_vllm = {
        __inherited_from = "openai", -- <- important (note spelling!)
        api_key_name = "",
        endpoint = "http://localhost:8000/v1", -- vLLM base URL
        model = "/models/Qwen2-1.5B-Instruct-GPTQ-Int4",
        disable_tools = true, -- disable tools!
        -- extra_request_body = {
        --   temperature = 0,
        --   max_tokens = 4096,
        -- },
      },
    },
    -- for example
    -- provider = "claude",
    -- providers = {
    --   claude = {
    --     endpoint = "https://api.anthropic.com",
    --     model = "claude-sonnet-4-20250514",
    --     timeout = 30000, -- Timeout in milliseconds
    --     extra_request_body = {
    --       temperature = 0.75,
    --       max_tokens = 20480,
    --     },
    --   },
    -- moonshot = {
    --   endpoint = "https://api.moonshot.ai/v1",
    --   model = "kimi-k2-0711-preview",
    --   timeout = 30000, -- Timeout in milliseconds
    --   extra_request_body = {
    --     temperature = 0.75,
    --     max_tokens = 32768,
    --   },
    -- },
    -- },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    {
      -- support for image pasting
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        -- recommended settings
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          -- required for Windows users
          use_absolute_path = true,
        },
      },
    },
    {
      -- Make sure to set this up properly if you have lazy=true
      "MeanderingProgrammer/render-markdown.nvim",
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
  },
}
