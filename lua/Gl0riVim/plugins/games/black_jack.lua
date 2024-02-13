local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (black_jack.lua)", vim.log.levels.WARN)
  return
end

local black_opts = settings.games_plugins.black_jack

local black_jack = {}

if black_opts.enable then
  black_jack = {
    "alanfortlink/blackjack.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = black_opts.cmd,
    keys = black_opts.keys,
    opts = {
      card_style = black_opts.card_style, -- Can be "mini" or "large".
      suit_style = black_opts.suit_style, -- Can be "black" or "white".
      -- Default location to store the scores.json file.
      scores_path = vim.fn.expand(vim.fn.stdpath("state") .. "/blackjack_scores.json"),
    },
  }
end

return black_jack
