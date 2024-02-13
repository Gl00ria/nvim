local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (speed_typer.lua)", vim.log.levels.WARN)
  return
end

local typer_opts = settings.games_plugins.speed_typer

local speed_typer = {}

if typer_opts.enable then
  speed_typer = {
    "NStefan002/speedtyper.nvim",
    cmd = "Speedtyper",
    keys = typer_opts.keys,
    opts = {
      window = {
        height = 5, -- integer >= 5 | float in range (0, 1)
        width = 0.55, -- integer | float in range (0, 1)
        border = "rounded", -- "none" | "single" | "double" | "rounded" | "shadow" | "solid"
      },
      language = "en", -- "en" | "sr" currently only only supports English and Serbian
      game_modes = { -- preferred settings for different game modes
        -- type until time expires
        countdown = {
          time = 30,
        },
        -- type until you complete one page
        stopwatch = {
          hide_time = true, -- hide time while typing
        },
        rain = {
          initial_speed = 1.5, -- words fall down by one line every x seconds
          throttle = 7, -- increase speed every x seconds (set to -1 for constant speed)
          lives = 3,
        },
      },
      -- specify highlight group for each component
      highlights = {
        untyped_text = "Comment",
        typo = "ErrorMsg",
        clock = "ErrorMsg",
        falling_word_typed = "DiagnostcOk",
        falling_word = "Normal",
        falling_word_warning1 = "WarningMsg",
        falling_word_warning2 = "ErrorMsg",
      },
    },
  }
end

return speed_typer
