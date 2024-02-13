local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (duck.lua)", vim.log.levels.WARN)
  return
end

local duck_opts = settings.games_plugins.duck

local duck = {}

if duck_opts.enable then
  duck = {
    "tamton-aquib/duck.nvim",
    keys = {
      {
        "<leader>Ghd",
        function()
          require("duck").hatch("🦆", 1.5)
        end,
        desc = "Duck 🦆 ",
      },
      {
        "<leader>Ghg",
        function()
          require("duck").hatch("ඞ", 4)
        end,
        desc = "Ghost ඞ ",
      },
      {
        "<leader>GhH",
        function()
          require("duck").hatch("🐎", 5)
        end,
        desc = "Horse 🐎",
      },
      {
        "<leader>GhD",
        function()
          require("duck").hatch("🦖", 3)
        end,
        desc = "Dinosaur 🦖",
      },
      {
        "<leader>GhC",
        function()
          require("duck").hatch("🦀", 1)
        end,
        desc = "Crab 🦀",
      },
      {
        "<leader>Ghc",
        function()
          require("duck").hatch("🐤", 3)
        end,
        desc = "Chick 🐤",
      },
      {
        "<leader>Ghk",
        function()
          require("duck").hatch("🐈", 2)
        end,
        desc = "Kitty 🐈",
      },
      {
        "<leader>GhA",
        function()
          require("duck").hatch()
          require("duck").hatch("🦀", 1)
          require("duck").hatch("🐈", 2)
          require("duck").hatch("🦖", 3)
          require("duck").hatch("🐤", 3)
          require("duck").hatch("ඞ", 4)
          require("duck").hatch("🐎", 5)
        end,
        desc = "All",
      },
      {
        "<leader>Ghx",
        function()
          require("duck").cook()
        end,
        desc = "Cook",
      },
      {
        "<leader>GhX",
        function()
          require("duck").cook()
          require("duck").cook()
          require("duck").cook()
          require("duck").cook()
          require("duck").cook()
          require("duck").cook()
          require("duck").cook()
        end,
        desc = "Cook all",
      },
    },
  }
end

return duck
