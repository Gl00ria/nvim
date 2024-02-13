local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (sudoku.lua)", vim.log.levels.WARN)
  return
end

local sudoku_opts = settings.games_plugins.sudoku

local sudoku = {}

if sudoku_opts.enable then
  sudoku = {
    "jim-fx/sudoku.nvim",
    cmd = sudoku_opts.cmd,
    keys = sudoku_opts.keys,
    opts = {
      -- save the settings under vim.fn.stdpath("data"), usually ~/.local/share/nvim,
      persist_settings = true,
      persist_games = true, -- persist a history of all played games
      default_mappings = true,
      -- if set to false you need to set your own, like the following:
      mappings = {
        { key = "x", action = "clear_cell" },
        { key = "r1", action = "insert=1" },
        { key = "r2", action = "insert=2" },
        { key = "r3", action = "insert=3" },
        { key = "r4", action = "insert=4" },
        { key = "r5", action = "insert=5" },
        { key = "r6", action = "insert=6" },
        { key = "r7", action = "insert=7" },
        { key = "r8", action = "insert=8" },
        { key = "r9", action = "insert=9" },
        { key = "gn", action = "new_game" },
        { key = "gr", action = "reset_game" },
        { key = "gs", action = "view=settings" },
        { key = "gt", action = "view=tip" },
        { key = "gz", action = "view=zen" },
        { key = "gh", action = "view=help" },
        { key = "u", action = "undo" },
        { key = "<C-r>", action = "redo" },
        { key = "+", action = "increment" },
        { key = "-", action = "decrement" },
      },
    },
  }
end

return sudoku
