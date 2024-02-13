local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (AIs.lua)", vim.log.levels.WARN)
  return
end

local ai_opts = settings.ai_plugins

local codeium = {}
local tabnine = {}

if ai_opts.codeium.enable then
  codeium = {
    "jcdickinson/codeium.nvim",
    event = ai_opts.codeium.event,
    cmd = ai_opts.codeium.cmd,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
    },
  }
end

if ai_opts.tabnine.enable then
  tabnine = {
    "tzachar/cmp-tabnine",
    event = ai_opts.tabnine.event,
    build = "./install.sh",
    dependencies = { "hrsh7th/nvim-cmp" },
    config = function()
      local tabnine_status, tabninee_ = pcall(require, "cmp_tabnine.config")
      if not tabnine_status then
        vim.notify("Plugin [tabnine] failed to load within (AIs.lua)", vim.log.levels.WARN)
        return
      end
      tabninee_:setup({
        max_lines = 1000,
        max_num_results = 20,
        sort = true,
        run_on_every_keystroke = true,
        snippet_placeholder = "..",
        ignored_file_types = {
          -- uncomment to ignore in lua:
          -- lua = true
          -- html = true;
        },
        show_prediction_strength = false,
      })
    end,
  }
end

return { codeium, tabnine }
