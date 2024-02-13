local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (database.lua)", vim.log.levels.WARN)
  return
end

local database_opts = settings.langs_control.database

local database = {}

if database_opts.enable then
  database = {
    {
      "tpope/vim-dadbod",
      dependencies = {
        "kristijanhusak/vim-dadbod-ui",
        "kristijanhusak/vim-dadbod-completion",
      },
      opts = {
        db_competion = function()
          require("cmp").setup.buffer({ sources = { { name = "vim-dadbod-completion" } } })
        end,
      },
      config = function(_, opts)
        vim.g.db_ui_save_location = vim.fn.stdpath("config") .. require("plenary.path").path.sep .. "db_ui"

        vim.api.nvim_create_autocmd("FileType", {
          pattern = {
            "sql",
          },
          command = [[setlocal omnifunc=vim_dadbod_completion#omni]],
        })

        vim.api.nvim_create_autocmd("FileType", {
          pattern = {
            "sql",
            "mysql",
            "plsql",
          },
          callback = function()
            vim.schedule(opts.db_completion)
          end,
        })
      end,
      keys = database_opts.keys,
    },
  }
end

return database
