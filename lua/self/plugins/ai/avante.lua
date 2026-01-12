-- HACK:
-- - test later its too slow compare to CodeCompanion.nvim & over loads the CPU & GPU
-- - see (https://github.com/yetone/avante.nvim/issues/1904) for multi model
return {
  enabled = false,
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
    provider = "ollama",
    providers = {
      ollama = {
        endpoint = "http://localhost:11434",
        model = "granite3.1-moe:3b",
        max_tokens = 512, -- reduce token limit for responses
        context_size = 2048, -- only keep this many tokens of history
        streaming = false, -- disable streaming
        temperature = 0.7, -- maybe lower or adjust
        -- disable_tools = true,
      },
    },
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
